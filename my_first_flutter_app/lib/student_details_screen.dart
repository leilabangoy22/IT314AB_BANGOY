import 'package:flutter/material.dart';

class StudentDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> student;

  const StudentDetailsScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Details Screen')),
      body: Center(
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
              'Status: ${student['active'] ? 'ACTIVE' : 'INACTIVE'}',
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
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Edit ${student['name']}'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Name',
                              hintText: student['name'],
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Course',
                              hintText: student['course'],
                            ),
                          ),
                          TextField(
                            decoration: InputDecoration(
                              labelText: 'Hobby',
                              hintText: student['hobby'],
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Save'),
                        ),
                      ],
                    );
                  },
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Student'),
            ),
          ],
        ),
      ),
    );
  }
}
