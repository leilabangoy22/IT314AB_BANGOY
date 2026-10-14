
import 'package:flutter/material.dart';
import 'student_list_screen.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {
  final _formKey = GlobalKey<FormState>();

  final studentIdController = TextEditingController();
  final fullNameController = TextEditingController();
  final courseController = TextEditingController();
  final yearLevelController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    studentIdController.dispose();
    fullNameController.dispose();
    courseController.dispose();
    yearLevelController.dispose();
    emailController.dispose();
    super.dispose();
  }

  Future<void> submitStudent() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    students.add({
      'studentId': studentIdController.text.trim(),
      'name': fullNameController.text.trim(),
      'course': courseController.text.trim(),
      'yearLevel': int.parse(yearLevelController.text.trim()),
      'email': emailController.text.trim(),
      'age': 0,
      'hobby': 'Not Provided',
      'favoriteSubject': 'Not Provided',
      'image': 'assets/Profile.jpg',
      'editing': false,
      'active': true,
    });

    sortStudents();
    await saveStudents();

    if (mounted) {
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Add Student',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Text(
                'Student Enrollment Form',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              TextFormField(
                controller: studentIdController,
                decoration: const InputDecoration(
                  labelText: 'Student ID',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Student ID';
                  }

                  final exists = students.any(
                    (student) =>
                        student['studentId']
                            .toString()
                            .toLowerCase() ==
                        value.trim().toLowerCase(),
                  );

                  if (exists) {
                    return 'Student ID already exists';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: fullNameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Full Name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Course';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: yearLevelController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Year Level (1-4)',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Year Level';
                  }

                  final year = int.tryParse(value.trim());

                  if (year == null || year < 1 || year > 4) {
                    return 'Year Level must be from 1 to 4';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 15),

              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter Email Address';
                  }

                  final validEmail = RegExp(
                    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                  ).hasMatch(value.trim());

                  if (!validEmail) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 25),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: submitStudent,
                  child: const Text('Submit'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
