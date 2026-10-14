import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

List<Map<String, dynamic>> students = [
  {
    'image': 'assets/Profile.jpg',
    'name': 'Leila G. Bangoy',
    'course': 'BSIT',
    'yearLevel': 3,
    'age': 20,
    'hobby': 'Watching Movies',
    'studentId': '2026-001',
    'email': 'leila@gmail.com',
    'favoriteSubject': 'PE',
    'editing': false,
    'active': false,
  },
  {
    'image': 'assets/Profile2.jpg',
    'name': 'Karol S. Pal',
    'course': 'BSIT',
    'yearLevel': 3,
    'age': 20,
    'hobby': 'Sleeping',
    'studentId': '2026-002',
    'email': 'karol@gmail.com',
    'favoriteSubject': 'Theo',
    'editing': false,
    'active': true,
  },
  {
    'image': 'assets/Profile3.jpg',
    'name': 'Shairha May Ejares',
    'course': 'BSIT',
    'yearLevel': 3,
    'age': 20,
    'hobby': 'Drawing',
    'studentId': '2026-003',
    'email': 'shairha@gmail.com',
    'favoriteSubject': 'GEC',
    'editing': false,
    'active': true,
  },
  {
    'image': 'assets/Profile4.jpg',
    'name': 'Cassandra Gayle R. Oraiz',
    'course': 'BSIT',
    'yearLevel': 3,
    'age': 20,
    'hobby': 'Not Provided',
    'studentId': '2026-004',
    'email': 'cass@gmail.com',
    'favoriteSubject': 'Arts',
    'editing': false,
    'active': false,
  },
  {
    'image': 'assets/Profile5.jpg',
    'name': 'James Neil Maano',
    'course': 'BSIT',
    'yearLevel': 3,
    'age': 20,
    'hobby': 'Not Provided',
    'studentId': '2026-005',
    'email': 'james@gmail.com',
    'favoriteSubject': 'Programming',
    'editing': false,
    'active': true,
  },
  {
    'image': 'assets/Profile6.jpg',
    'name': 'Carl Tomas',
    'course': 'BSIT - 3',
    'yearLevel': 3,
    'age': 20,
    'hobby': 'Reading',
    'studentId': '2026-006',
    'email': 'carl@gmail.com',
    'favoriteSubject': 'Programming',
    'editing': false,
    'active': false,
  },
];

void sortStudents() {
  students.sort(
    (a, b) => a['name'].toString().toLowerCase().compareTo(
          b['name'].toString().toLowerCase(),
        ),
  );
}

Future<void> saveStudents() async {
  final prefs = await SharedPreferences.getInstance();

  await prefs.setString(
    'saved_students',
    jsonEncode(students),
  );
}

Future<void> loadStudents() async {
  final prefs = await SharedPreferences.getInstance();
  final savedData = prefs.getString('saved_students');

  if (savedData != null) {
    final List<dynamic> decodedData = jsonDecode(savedData);

    students = decodedData.map((student) {
      return Map<String, dynamic>.from(student);
    }).toList();
  } else {
    sortStudents();
    await saveStudents();
  }

  sortStudents();
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() =>
      _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadStudentList();
  }

  Future<void> loadStudentList() async {
    await loadStudents();

    if (!mounted) return;

    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    setState(() {
      isLoading = false;
      sortStudents();
    });
  }

  Future<void> openAddStudent() async {
    final result = await Navigator.pushNamed(
      context,
      '/add-student',
    );

    if (result == true && mounted) {
      await loadStudents();

      if (!mounted) return;

      setState(() {
        sortStudents();
      });
    }
  }

  Future<void> editStudent(
    Map<String, dynamic> student,
  ) async {
    final nameController = TextEditingController(
      text: student['name']?.toString() ?? '',
    );

    final courseController = TextEditingController(
      text: student['course']?.toString() ?? '',
    );

    final hobbyController = TextEditingController(
      text: student['hobby']?.toString() ?? '',
    );

    final idController = TextEditingController(
      text: student['studentId']?.toString() ?? '',
    );

    final formKey = GlobalKey<FormState>();

    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Edit Student'),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Full Name',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter student name';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: idController,
                    decoration: const InputDecoration(
                      labelText: 'Student ID',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter student ID';
                      }

                      final duplicate = students.any((other) {
                        return !identical(other, student) &&
                            other['studentId']
                                    .toString()
                                    .toLowerCase() ==
                                value.trim().toLowerCase();
                      });

                      if (duplicate) {
                        return 'Student ID already exists';
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
                      if (value == null || value.trim().isEmpty) {
                        return 'Enter course';
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
      setState(() {
        student['name'] = nameController.text.trim();
        student['studentId'] = idController.text.trim();
        student['course'] = courseController.text.trim();
        student['hobby'] = hobbyController.text.trim();

        sortStudents();
      });
      
      await saveStudents();

      if (mounted) {
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
    idController.dispose();
  }

  Future<void> deleteStudent(
    Map<String, dynamic> student,
  ) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: const Text(
            'Are you sure you want to delete this student?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true && mounted) {
      setState(() {
        students.remove(student);
      });

      await saveStudents();

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Student deleted successfully!'),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Student List Screen',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: openAddStudent,
            icon: const Icon(
              Icons.person_add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/flutterimage.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 15),
                    Text(
                      'Loading students...',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              )
            : students.isEmpty
                ? const Center(
                    child: Text(
                      'No students found.',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset(
                              student['image'] ??
                                  'assets/Profile.jpg',
                              width: 350,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (
                                context,
                                error,
                                stackTrace,
                              ) {
                                return const Icon(
                                  Icons.person,
                                  size: 100,
                                  color: Colors.white,
                                );
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(
                                context,
                                '/student-details',
                                arguments: student,
                              );

                              if (!mounted) return;

                              await loadStudents();

                              if (!mounted) return;

                              setState(() {
                                sortStudents();
                              });
                            },
                            child: Card(
                              color: const Color.fromARGB(
                                53,
                                103,
                                102,
                                102,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          student['active'] == true
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: student['active'] == true
                                              ? Colors.green
                                              : Colors.red,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          student['active'] == true
                                              ? 'ACTIVE'
                                              : 'INACTIVE',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: student['active'] == true
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    if (student['active'] != true)
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          SizedBox(width: 6),
                                          Flexible(
                                            child: Text(
                                              'INACTIVE - Please check status',
                                              style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    const SizedBox(height: 8),
                                    Text(
                                      student['name'] ?? 'Unknown',
                                      style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(
                                          255,
                                          249,
                                          249,
                                          250,
                                        ),
                                        shadows: [
                                          Shadow(
                                            blurRadius: 6,
                                            color: Colors.black54,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      student['course'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 6,
                                            color: Colors.black54,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Age: ${student['age']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 6,
                                            color: Colors.black54,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      student['hobby'] ?? '',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 6,
                                            color: Colors.black54,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Text(
                                      'Student ID: ${student['studentId']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 6,
                                            color: Colors.black54,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Email: ${student['email']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 6,
                                            color: Colors.black54,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      'Favorite Subject: ${student['favoriteSubject']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        shadows: [
                                          Shadow(
                                            blurRadius: 6,
                                            color: Colors.black54,
                                            offset: Offset(1, 1),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            editStudent(student);
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            deleteStudent(student);
                                          },
                                          icon: const Icon(
                                            Icons.delete,
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              90,
                                              90,
                                            ),
                                            size: 40,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      );
                    },
                  ),
      ),
    );
  }
}