
import 'package:flutter/material.dart';
import 'student_list_screen.dart';

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

class _StudentDetailsScreenState
    extends State<StudentDetailsScreen> {
  Future<void> editStudent() async {
    final nameController = TextEditingController(
      text: widget.student['name']?.toString() ?? '',
    );

    final courseController = TextEditingController(
      text: widget.student['course']?.toString() ?? '',
    );

    final hobbyController = TextEditingController(
      text: widget.student['hobby']?.toString() ?? '',
    );

    final emailController = TextEditingController(
      text: widget.student['email']?.toString() ?? '',
    );

    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text('Edit ${widget.student['name']}'),
          content: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter a name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: courseController,
                    decoration: const InputDecoration(
                      labelText: 'Course',
                    ),
                    validator: (value) {
                      if (value == null ||
                          value.trim().isEmpty) {
                        return 'Please enter a course';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: hobbyController,
                    decoration: const InputDecoration(
                      labelText: 'Hobby',
                    ),
                  ),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null ||
                          !RegExp(
                            r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
                          ).hasMatch(value.trim())) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(dialogContext, true);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (result == true && mounted) {
      widget.student['name'] = nameController.text.trim();
      widget.student['course'] = courseController.text.trim();
      widget.student['hobby'] = hobbyController.text.trim();
      widget.student['email'] = emailController.text.trim();

      sortStudents();
      await saveStudents();

      if (mounted) {
        setState(() {});

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Student information updated!'),
          ),
        );
      }
    }

    nameController.dispose();
    courseController.dispose();
    hobbyController.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final student = widget.student;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Details Screen'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Name: ${student['name']}',
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: 10),
              Text(
                'Student ID: ${student['studentId']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Course: ${student['course']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Status: ${student['active'] == true ? 'ACTIVE' : 'INACTIVE'}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Age: ${student['age']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Hobby: ${student['hobby']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Email: ${student['email']}',
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 10),
              Text(
                'Favorite Subject: ${student['favoriteSubject']}',
                style: const TextStyle(fontSize: 20),
              ),
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
