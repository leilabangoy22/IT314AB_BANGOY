import 'package:flutter/material.dart';
import 'api_service.dart';
import 'models.dart';

class EnrollmentScreen extends StatefulWidget {
  const EnrollmentScreen({super.key});
  @override
  State<EnrollmentScreen> createState() => _EnrollmentScreenState();
}

class _EnrollmentScreenState extends State<EnrollmentScreen> {
  List<Map<String, dynamic>> students = [];
  List<Subject> subjects = [];
  List<Schedule> schedules = [];
  List<Enrollment> currentEnrollments = [];
  
  int? selectedStudentId; 
  Subject? selectedSubject;
  Schedule? selectedSchedule;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    try {
      final s = await ApiService.getStudents();
      final sub = await ApiService.getSubjects();
      final sch = await ApiService.getSchedules();
      setState(() {
        students = s; subjects = sub; schedules = sch; isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Load Error: $e')));
    }
  }

  Future<void> loadStudentEnrollments(int studentId) async {
    final data = await ApiService.getStudentEnrollments(studentId);
    if (mounted) setState(() { currentEnrollments = data; });
  }

  int _timeToMinutes(String timeStr) {
    try {
      final parts = timeStr.split(':');
      if (parts.length >= 2) {
        return int.parse(parts[0]) * 60 + int.parse(parts[1]);
      }
    } catch (e) {
      return 0;
    }
    return 0;
  }

  Future<void> validateAndEnroll() async {
    if (selectedStudentId == null || selectedSubject == null || selectedSchedule == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please select all fields')));
      return;
    }

    final existingEnrollments = await ApiService.getStudentEnrollments(selectedStudentId!);
    
    bool alreadyEnrolled = existingEnrollments.any((e) => 
      e.subjectId == selectedSubject!.subjectId && e.status == 'Enrolled');
    if (alreadyEnrolled) {
      _showErrorDialog('Error: Student is already enrolled in this subject!');
      return;
    }

    final allSchedules = await ApiService.getSchedules();
    
    for (var enrollment in existingEnrollments) {
      if (enrollment.status == 'Dropped') continue;
      
      final existingSchedule = allSchedules.firstWhere(
        (s) => s.scheduleId == enrollment.scheduleId, 
        orElse: () => Schedule(scheduleId: 0, subjectId: 0, dayOfWeek: '', startTime: '', endTime: '', room: '', slotCapacity: 0)
      );

      if (existingSchedule.dayOfWeek == selectedSchedule!.dayOfWeek) {
        final newStart = _timeToMinutes(selectedSchedule!.startTime);
        final newEnd = _timeToMinutes(selectedSchedule!.endTime);
        final oldStart = _timeToMinutes(existingSchedule.startTime);
        final oldEnd = _timeToMinutes(existingSchedule.endTime);

        if (newStart < oldEnd && newEnd > oldStart) {
          _showErrorDialog('Schedule Conflict: This schedule overlaps with an existing enrolled subject on ${selectedSchedule!.dayOfWeek} at ${existingSchedule.startTime}-${existingSchedule.endTime}.');
          return;
        }
      }
    }

    final allEnrollments = await ApiService.getAllEnrollments();
    final enrolledCount = allEnrollments.where((e) => e.scheduleId == selectedSchedule!.scheduleId && e.status == 'Enrolled').length;
    
    if (enrolledCount >= selectedSchedule!.slotCapacity) {
      _showErrorDialog('Slot Capacity Reached: This schedule is already full (${selectedSchedule!.slotCapacity} slots).');
      return;
    }

    try {
      await ApiService.enrollStudent(
        selectedStudentId!, 
        selectedSubject!.subjectId, 
        selectedSchedule!.scheduleId
      );
      
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enrollment successful!')));
      loadStudentEnrollments(selectedStudentId!);
    } catch (e) {
      _showErrorDialog(e.toString());
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enrollment Failed'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('OK'))
        ],
      ),
    );
  }

  // NEW: Function to show enrollment details
  void _showEnrollmentDetails(Enrollment enrollment) {
    // Find the related Subject and Schedule
    final subject = subjects.firstWhere(
      (s) => s.subjectId == enrollment.subjectId, 
      orElse: () => Subject(subjectId: 0, subjectCode: 'Unknown', subjectName: 'Unknown Subject', units: 0, description: '')
    );
    final schedule = schedules.firstWhere(
      (s) => s.scheduleId == enrollment.scheduleId, 
      orElse: () => Schedule(scheduleId: 0, subjectId: 0, dayOfWeek: 'Unknown', startTime: '', endTime: '', room: 'Unknown', slotCapacity: 0)
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${subject.subjectCode} - ${subject.subjectName}'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Enrollment ID: ${enrollment.enrollmentId}'),
            const SizedBox(height: 8),
            Text('Subject: ${subject.subjectName} (${subject.units} units)'),
            const SizedBox(height: 8),
            Text('Schedule: ${schedule.dayOfWeek}, ${schedule.startTime} - ${schedule.endTime}'),
            const SizedBox(height: 8),
            Text('Room: ${schedule.room}'),
            const SizedBox(height: 8),
            Text('Status: ${enrollment.status}', style: TextStyle(
              color: enrollment.status == 'Enrolled' ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold
            )),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Close'))
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.blue, title: const Text('Enrollment System', style: TextStyle(color: Colors.white))),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DropdownButtonFormField<int>(
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Select Student', border: OutlineInputBorder()),
              value: selectedStudentId,
              items: students.map((s) => DropdownMenuItem<int>(
                value: s['dbId'] as int, 
                child: Text(s['name'] ?? 'Unknown', overflow: TextOverflow.ellipsis)
              )).toList(),
              onChanged: (val) {
                setState(() { selectedStudentId = val; currentEnrollments = []; });
                if (val != null) loadStudentEnrollments(val);
              },
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<Subject>(
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Select Subject', border: OutlineInputBorder()),
              value: selectedSubject,
              items: subjects.map((s) => DropdownMenuItem(
                value: s, 
                child: Text('${s.subjectCode} - ${s.subjectName}', overflow: TextOverflow.ellipsis)
              )).toList(),
              onChanged: (val) => setState(() => selectedSubject = val),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<Schedule>(
              isExpanded: true,
              decoration: const InputDecoration(labelText: 'Select Schedule', border: OutlineInputBorder()),
              value: selectedSchedule,
              items: schedules.map((s) => DropdownMenuItem(
                value: s, 
                child: Text('${s.dayOfWeek} ${s.startTime}-${s.endTime} (Slots: ${s.slotCapacity})', overflow: TextOverflow.ellipsis)
              )).toList(),
              onChanged: (val) => setState(() => selectedSchedule = val),
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: validateAndEnroll, child: const Text('Enroll Student')),
            const SizedBox(height: 30),
            const Text('Current Enrollments', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...currentEnrollments.map((e) {
              // Look up the subject name for display on the card
              final subjectName = subjects.firstWhere(
                (s) => s.subjectId == e.subjectId, 
                orElse: () => Subject(subjectId: 0, subjectCode: '', subjectName: 'Unknown', units: 0, description: '')
              ).subjectName;

              return Card(
                child: InkWell(
                  onTap: () => _showEnrollmentDetails(e), // ADDED: Click to view details
                  borderRadius: BorderRadius.circular(4),
                  child: ListTile(
                    title: Text('Subject: $subjectName'), // Improved display
                    subtitle: Text('Status: ${e.status}'),
                    trailing: IconButton(
                      icon: const Icon(Icons.cancel, color: Colors.red),
                      onPressed: () async {
                        await ApiService.dropEnrollment(e.enrollmentId);
                        loadStudentEnrollments(selectedStudentId!);
                      },
                    ),
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}