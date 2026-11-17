const express = require('express');
const cors = require('cors');
const { Pool } = require('pg');
const path = require('path');
require('dotenv').config({ path: path.join(__dirname, 'backend.env') });

const app = express();
const port = process.env.PORT || 3000;
const pool = new Pool({ connectionString: process.env.DATABASE_URL, ssl: { rejectUnauthorized: false } });

app.use(cors());
app.use(express.json());

const resources = {
  students: { table: 'Students', id: 'studentid', fields: ['studentname','programid','student_number','first_name','last_name','email','course','year_level','contact_number','created_at'] },
  programs: { table: 'Programs', id: 'programid', fields: ['programcode','programname'] },
  subjects: { table: 'Subject', id: 'subject_id', fields: ['subject_code','subject_name','units','description'] },
  schedules: { table: 'Schedule', id: 'schedule_id', fields: ['subject_id','day_of_week','start_time','end_time','room','slot_capacity'] },
  grades: { table: 'grades', id: 'grade_id', fields: ['student_id','subject','score','enrollment_id','remarks','date_recorded'] }
};

const qid = value => '"' + String(value).replace(/"/g, '""') + '"';
const getResource = name => resources[String(name || '').toLowerCase()];

const errorResponse = (res, error, fallback) => {
  console.error("=== DATABASE ERROR ===");
  console.error(error.message); 
  console.error("======================");
  
  if (error.code === '23505') return res.status(409).json({ error: 'A record with the same unique value already exists.' });
  if (error.code === '23503') return res.status(409).json({ error: 'This change conflicts with a related record. Check the selected foreign-key IDs first.' });
  if (error.code === '23502') return res.status(400).json({ error: `A required field is missing: ${error.column || 'required field'}.` });
  if (error.code === '22P02' || error.code === '22007' || error.code === '22008' || error.code === '22003') return res.status(400).json({ error: 'One or more values have the wrong data type or format.' });
  
  return res.status(500).json({ error: fallback });
};

app.get('/api/health', async (req, res) => {
  try { 
    const r = await pool.query('SELECT current_database() AS database'); 
    res.json({ status: 'ok', database: r.rows[0].database }); 
  } catch (e) { 
    errorResponse(res, e, 'Database connection failed.'); 
  }
});

app.get('/api/students', async (req, res) => {
  try { 
    const r = await pool.query('SELECT studentid, studentname, programid, student_number, first_name, last_name, email, course, year_level, contact_number, created_at FROM "Students" ORDER BY studentid'); 
    res.json(r.rows); 
  } catch (e) { 
    errorResponse(res, e, 'Could not load students.'); 
  }
});

app.post('/api/students', async (req, res) => {
  const b = req.body || {};
  const full = String(b.studentname || `${b.first_name || ''} ${b.last_name || ''}`).trim();
  const parts = full.split(/\s+/);
  
  if (!String(b.student_number || '').trim() || !full || !String(b.first_name || parts[0] || '').trim() || !String(b.last_name || parts.slice(1).join(' ') || '').trim()) {
    return res.status(400).json({ error: 'Student number, first name, last name, and full name are required.' });
  }
  
  try {
    const client = await pool.connect();
    try {
      await client.query('BEGIN'); 
      await client.query('SELECT pg_advisory_xact_lock($1)', [731905]);
      
      const id = (await client.query('SELECT COALESCE(MAX(studentid),0)+1 AS id FROM "Students"')).rows[0].id;
      const r = await client.query(
        'INSERT INTO "Students" (studentid,studentname,programid,student_number,first_name,last_name,email,course,year_level,contact_number) VALUES ($1,$2,$3,$4,$5,$6,$7,$8,$9,$10) RETURNING *', 
        [id, full, b.programid || null, String(b.student_number).trim(), String(b.first_name || parts[0]).trim(), String(b.last_name || parts.slice(1).join(' ')).trim(), b.email || null, b.course || null, b.year_level === '' || b.year_level == null ? null : Number(b.year_level), b.contact_number || null]
      );
      await client.query('COMMIT'); 
      res.status(201).json(r.rows[0]);
    } catch(e) { 
      await client.query('ROLLBACK'); 
      throw e; 
    } finally { 
      client.release(); 
    }
  } catch(e) { 
    errorResponse(res, e, 'Could not add student.'); 
  }
});

app.put('/api/students/:id', async (req, res) => {
  const b = req.body || {};
  const full = String(b.studentname || `${b.first_name || ''} ${b.last_name || ''}`).trim();
  const parts = full.split(/\s+/);
  const studentNumber = String(b.student_number || '').trim();
  const first = String(b.first_name || parts[0] || '').trim();
  const last = String(b.last_name || parts.slice(1).join(' ') || '').trim();
  
  if (!studentNumber || !full || !first || !last) {
    return res.status(400).json({ error: 'Student number, first name, and last name are required.' });
  }
  
  const year = b.year_level === '' || b.year_level == null ? null : Number(b.year_level);
  if (year !== null && (!Number.isInteger(year) || year < 1 || year > 6)) {
    return res.status(400).json({ error: 'Year level must be a whole number from 1 to 6, or blank.' });
  }

  try {
    const id = Number(req.params.id);
    if (isNaN(id)) return res.status(400).json({ error: 'Invalid student ID format.' });

    const r = await pool.query(
      'UPDATE "Students" SET studentname=$1, programid=$2, student_number=$3, first_name=$4, last_name=$5, email=$6, course=$7, year_level=$8, contact_number=$9 WHERE studentid=$10 RETURNING *', 
      [full, b.programid || null, studentNumber, first, last, b.email || null, b.course || null, year, b.contact_number || null, id]
    );

    if (!r.rowCount) {
      return res.status(404).json({ error: 'Student not found.' });
    }
    
    res.json(r.rows[0]);
  } catch(e) { 
    errorResponse(res, e, 'Could not update student.'); 
  }
});

app.delete('/api/students/:id', async (req, res) => {
  try { 
    const r = await pool.query('DELETE FROM "Students" WHERE studentid=$1 RETURNING studentid', [Number(req.params.id)]); 
    if (!r.rowCount) return res.status(404).json({ error: 'Student not found.' }); 
    res.json({ message: 'Student deleted.' }); 
  } catch(e) { 
    errorResponse(res, e, 'Could not delete student.'); 
  }
});

// --- CUSTOM ENROLLMENT ROUTES ---
app.get('/api/data/enrollments', async (req, res) => {
  try {
    const r = await pool.query('SELECT * FROM "Enrollment" ORDER BY enrollment_id');
    res.json(r.rows);
  } catch (e) {
    errorResponse(res, e, 'Could not load enrollments.');
  }
});

app.post('/api/data/enrollments', async (req, res) => {
  const b = req.body || {};
  const studentId = Number(b.student_id);
  const subjectId = Number(b.subject_id);
  const scheduleId = Number(b.schedule_id);
  const status = String(b.status || 'Enrolled');

  try {
    const r = await pool.query(
      `INSERT INTO "Enrollment" (student_id, subject_id, schedule_id, status) 
       VALUES ($1::int, $2::int, $3::int, $4::varchar) RETURNING *`,
      [studentId, subjectId, scheduleId, status]
    );
    
    res.status(201).json(r.rows[0]);
  } catch (e) {
    if (e.code === '23505') {
      return res.status(409).json({ error: 'This student is already enrolled in this subject.' });
    }
    console.error("=== EXACT ENROLLMENT CRASH REASON ===");
    console.error(e.message);
    res.status(500).json({ error: e.message }); 
  }
});

app.delete('/api/data/enrollments/:id', async (req,res) => {
  try { 
    const r = await pool.query('DELETE FROM "Enrollment" WHERE enrollment_id=$1 RETURNING enrollment_id', [Number(req.params.id)]); 
    if (!r.rowCount) return res.status(404).json({error:'Record not found.'}); 
    res.json({message:'Record deleted.'}); 
  } catch(e) { 
    errorResponse(res,e,`Could not delete enrollment record.`); 
  }
});

// --- GENERIC DATA ROUTES (For Subjects, Schedules, Grades) ---
app.get('/api/data/:resource', async (req,res) => {
  const cfg = getResource(req.params.resource); 
  if (!cfg) return res.status(404).json({error:'Unknown resource.'});
  try { 
    const r = await pool.query(`SELECT * FROM ${qid(cfg.table)} ORDER BY ${qid(cfg.id)}`); 
    res.json(r.rows); 
  } catch(e) { 
    errorResponse(res,e,`Could not load ${req.params.resource}.`); 
  }
});

app.post('/api/data/:resource', async (req,res) => {
  const cfg = getResource(req.params.resource); 
  if (!cfg) return res.status(404).json({error:'Unknown resource.'});
  const body = req.body || {}; 
  const fields = cfg.fields.filter(f => Object.prototype.hasOwnProperty.call(body,f) && body[f] !== '' && body[f] !== null && body[f] !== undefined);
  
  if (!fields.length) return res.status(400).json({error:'Enter the record fields before saving.'});
  
  const client = await pool.connect();
  try {
    await client.query('BEGIN'); 
    await client.query('SELECT pg_advisory_xact_lock($1)', [731906]);
    const next = (await client.query(`SELECT COALESCE(MAX(${qid(cfg.id)}),0)+1 AS id FROM ${qid(cfg.table)}`)).rows[0].id;
    const values = fields.map(f => body[f] === '' ? null : body[f]);
    const cols = [cfg.id,...fields]; 
    const vals = [next,...values];
    const placeholders = vals.map((_,i)=>`$${i+1}`).join(',');
    const sql = `INSERT INTO ${qid(cfg.table)} (${cols.map(qid).join(',')}) VALUES (${placeholders}) RETURNING *`;
    const r = await client.query(sql, vals); 
    await client.query('COMMIT'); 
    res.status(201).json(r.rows[0]);
  } catch(e) { 
    await client.query('ROLLBACK'); 
    errorResponse(res,e,`Could not create ${req.params.resource} record.`); 
  } finally { 
    client.release(); 
  }
});

app.put('/api/data/:resource/:id', async (req,res) => {
  const cfg = getResource(req.params.resource); 
  if (!cfg) return res.status(404).json({error:'Unknown resource.'});
  const body = req.body || {}; 
  const fields = cfg.fields.filter(f => Object.prototype.hasOwnProperty.call(body,f));
  if (!fields.length) return res.status(400).json({error:'No editable fields were supplied.'});
  
  try {
    const values = fields.map(f => body[f] === '' ? null : body[f]); 
    values.push(Number(req.params.id));
    const set = fields.map((f,i)=>`${qid(f)}=$${i+1}`).join(',');
    const r = await pool.query(`UPDATE ${qid(cfg.table)} SET ${set} WHERE ${qid(cfg.id)}=$${values.length} RETURNING *`, values);
    if (!r.rowCount) return res.status(404).json({error:'Record not found.'}); 
    res.json(r.rows[0]);
  } catch(e) { 
    errorResponse(res,e,`Could not update ${req.params.resource} record.`); 
  }
});

app.delete('/api/data/:resource/:id', async (req,res) => {
  const cfg = getResource(req.params.resource); 
  if (!cfg) return res.status(404).json({error:'Unknown resource.'});
  try { 
    const r = await pool.query(`DELETE FROM ${qid(cfg.table)} WHERE ${qid(cfg.id)}=$1 RETURNING ${qid(cfg.id)}`, [Number(req.params.id)]); 
    if (!r.rowCount) return res.status(404).json({error:'Record not found.'}); 
    res.json({message:'Record deleted.'}); 
  } catch(e) { 
    errorResponse(res,e,`Could not delete ${req.params.resource} record.`); 
  }
});

app.listen(port, '0.0.0.0', () => console.log(`Backend running at http://localhost:${port}`));