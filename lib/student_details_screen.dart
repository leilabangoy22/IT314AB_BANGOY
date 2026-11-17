import 'package:flutter/material.dart';
import 'student_list_screen.dart';
import 'api_service.dart';

class StudentDetailsScreen extends StatefulWidget {
  final Map<String, dynamic> student;

  const StudentDetailsScreen({
    super.key,
    required this.student,
  });

  @override
  State<StudentDetailsScreen> createState() =>
      _StudentDetailsScreenState();
}

class _StudentDetailsScreenState extends State<StudentDetailsScreen> {
  Future<void> editStudent() async {
    // We reuse the EditStudentDialog from student_list_screen.dart
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return EditStudentDialog(student: widget.student);
      },
    );

    if (result == true && mounted) {
      try {
        await loadStudents();
        final updated = students.firstWhere(
          (item) => item['dbId'].toString() == widget.student['dbId'].toString(),
          orElse: () => widget.student,
        );
        widget.student.addAll(updated);
        if (mounted) {
          setState(() {});
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student information updated!')),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Update failed: $error')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.student;

    return Scaffold(
      appBar: AppBar(title: const Text('Student Details Screen')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Name: ${student['name']}', style: const TextStyle(fontSize: 22)),
              const SizedBox(height: 10),
              Text('Student ID: ${student['studentId']}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Course: ${student['course']}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Status: ${student['active'] == true ? 'ACTIVE' : 'INACTIVE'}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Age: ${student['age']}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Hobby: ${student['hobby']}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Email: ${student['email']}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 10),
              Text('Favorite Subject: ${student['favoriteSubject']}', style: const TextStyle(fontSize: 20)),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: editStudent,
                icon: const Icon(Icons.edit),
                label: const Text('Edit Student'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}