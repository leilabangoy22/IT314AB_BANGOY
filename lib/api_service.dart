import 'dart:convert';
import 'package:http/http.dart' as http;
import 'models.dart';

class ApiService {
  static const String baseUrl = 'http://localhost:3000/api';

  // --- STUDENTS ---
  static Future<List<Map<String, dynamic>>> getStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/students'));
    _check(response, const [200]);
    final decoded = jsonDecode(response.body);
    if (decoded is! List) throw Exception('Unexpected students response.');
    
    return decoded.map<Map<String, dynamic>>((row) {
      final data = Map<String, dynamic>.from(row);
      final fullName = (data['studentname'] ?? '${data['first_name'] ?? ''} ${data['last_name'] ?? ''}').toString().trim();
      final idValue = data['studentid'] ?? data['student_id'];
      
      return {
        'dbId': idValue, 
        'studentId': (data['student_number'] ?? '').toString(), 
        'name': fullName.isEmpty ? 'Unknown' : fullName, 
        'course': data['course'] ?? '', 
        'yearLevel': data['year_level'] ?? 1, 
        'email': data['email'] ?? '', 
        'age': 0, 
        'hobby': 'Not Provided', 
        'favoriteSubject': 'Not Provided', 
        'image': 'assets/Profile.jpg', 
        'editing': false, 
        'active': true
      };
    }).toList();
  }

  static Future<void> createStudent({required String studentNumber, required String fullName, required String course, required int yearLevel, required String email}) async {
    final parts = _splitName(fullName);
    final response = await http.post(
      Uri.parse('$baseUrl/students'), 
      headers: {'Content-Type': 'application/json'}, 
      body: jsonEncode({
        'student_number': studentNumber.trim(), 
        'studentname': fullName.trim(), 
        'first_name': parts.$1, 
        'last_name': parts.$2, 
        'course': course.trim(), 
        'year_level': yearLevel, 
        'email': email.trim()
      })
    );
    _check(response, const [200, 201]);
  }

  static Future<void> updateStudent({required int dbId, required String studentNumber, required String fullName, required String course, required int yearLevel, required String email}) async {
    final parts = _splitName(fullName);
    final response = await http.put(
      Uri.parse('$baseUrl/students/$dbId'), 
      headers: {'Content-Type': 'application/json'}, 
      body: jsonEncode({
        'student_number': studentNumber.trim(), 
        'studentname': fullName.trim(), 
        'first_name': parts.$1, 
        'last_name': parts.$2, 
        'course': course.trim(), 
        'year_level': yearLevel, 
        'email': email.trim()
      })
    );
    _check(response, const [200, 201, 204]);
  }

  static Future<void> deleteStudent(int dbId) async {
    final response = await http.delete(Uri.parse('$baseUrl/students/$dbId'));
    _check(response, const [200, 204]);
  }

  // --- SUBJECTS ---
  static Future<List<Subject>> getSubjects() async {
    final response = await http.get(Uri.parse('$baseUrl/data/subjects'));
    _check(response, const [200]);
    final decoded = jsonDecode(response.body) as List;
    return decoded.map((row) => Subject.fromJson(row)).toList();
  }

  static Future<void> createSubject(String code, String name, int units, String desc) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data/subjects'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'subject_code': code, 'subject_name': name, 'units': units, 'description': desc}),
    );
    _check(response, const [200, 201]);
  }

  static Future<void> updateSubject(int id, String code, String name, int units, String desc) async {
    final response = await http.put(
      Uri.parse('$baseUrl/data/subjects/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'subject_code': code, 'subject_name': name, 'units': units, 'description': desc}),
    );
    _check(response, const [200]);
  }

  static Future<void> deleteSubject(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/data/subjects/$id'));
    _check(response, const [200, 204]);
  }

  // --- SCHEDULES ---
  static Future<List<Schedule>> getSchedules() async {
    final response = await http.get(Uri.parse('$baseUrl/data/schedules'));
    _check(response, const [200]);
    final decoded = jsonDecode(response.body) as List;
    return decoded.map((row) => Schedule.fromJson(row)).toList();
  }

  static Future<void> createSchedule(int subjectId, String day, String start, String end, String room, int capacity) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data/schedules'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'subject_id': subjectId, 'day_of_week': day, 'start_time': start, 'end_time': end, 'room': room, 'slot_capacity': capacity}),
    );
    _check(response, const [200, 201]);
  }

  static Future<void> updateSchedule(int id, int subjectId, String day, String start, String end, String room, int capacity) async {
    final response = await http.put(
      Uri.parse('$baseUrl/data/schedules/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'subject_id': subjectId, 'day_of_week': day, 'start_time': start, 'end_time': end, 'room': room, 'slot_capacity': capacity}),
    );
    _check(response, const [200]);
  }

  static Future<void> deleteSchedule(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/data/schedules/$id'));
    _check(response, const [200, 204]);
  }

  // --- ENROLLMENTS ---
  static Future<List<Enrollment>> getStudentEnrollments(int studentId) async {
    final response = await http.get(Uri.parse('$baseUrl/data/enrollments'));
    _check(response, const [200]);
    final decoded = jsonDecode(response.body) as List;
    return decoded.map((row) => Enrollment.fromJson(row)).where((e) => e.studentId == studentId).toList();
  }

  static Future<List<Enrollment>> getAllEnrollments() async {
    final response = await http.get(Uri.parse('$baseUrl/data/enrollments'));
    _check(response, const [200]);
    final decoded = jsonDecode(response.body) as List;
    return decoded.map((row) => Enrollment.fromJson(row)).toList();
  }

  static Future<void> enrollStudent(int studentId, int subjectId, int scheduleId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data/enrollments'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'student_id': studentId, 
        'subject_id': subjectId, 
        'schedule_id': scheduleId, 
        'status': 'Enrolled'
      }),
    );
    
    if (response.statusCode != 200 && response.statusCode != 201) {
      throw Exception('Server says: ${response.body}');
    }
  }

  static Future<void> dropEnrollment(int enrollmentId) async {
    final response = await http.delete(Uri.parse('$baseUrl/data/enrollments/$enrollmentId'));
    _check(response, const [200, 204]);
  }

  // --- GRADES ---
  static Future<List<Grade>> getGrades() async {
    final response = await http.get(Uri.parse('$baseUrl/data/grades'));
    _check(response, const [200]);
    final decoded = jsonDecode(response.body) as List;
    return decoded.map((row) => Grade.fromJson(row)).toList();
  }

  static Future<void> addGrade(int studentId, String subject, double score, String remarks) async {
    final response = await http.post(
      Uri.parse('$baseUrl/data/grades'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'student_id': studentId, 'subject': subject, 'score': score, 'remarks': remarks}),
    );
    _check(response, const [200, 201]);
  }

  static Future<void> updateGrade(int id, int studentId, String subject, double score, String remarks) async {
    final response = await http.put(
      Uri.parse('$baseUrl/data/grades/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'student_id': studentId, 'subject': subject, 'score': score, 'remarks': remarks}),
    );
    _check(response, const [200]);
  }

  static Future<void> deleteGrade(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/data/grades/$id'));
    _check(response, const [200, 204]);
  }

  // --- HELPERS ---
  static void _check(http.Response response, List<int> accepted) {
    if (accepted.contains(response.statusCode) || (response.statusCode >= 200 && response.statusCode < 300)) return;
    try {
      if (response.body.isNotEmpty) { 
        final data = jsonDecode(response.body);
        if (data is Map && data['error'] != null) throw Exception(data['error'].toString());
      }
    } catch (e) {}
    throw Exception('Request failed (${response.statusCode}): ${response.body}');
  }

  static (String, String) _splitName(String name) {
    final parts = name.trim().split(RegExp(r'\s+'));
    if (parts.length < 2) return (parts.first, '');
    return (parts.first, parts.skip(1).join(' '));
  }
}