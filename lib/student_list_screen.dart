import 'package:flutter/material.dart';
import 'api_service.dart';

List<Map<String, dynamic>> students = [];

void sortStudents() {
  students.sort((a, b) => a['name'].toString().toLowerCase().compareTo(
        b['name'].toString().toLowerCase(),
      ));
}

Future<void> saveStudents() async {}

Future<void> loadStudents() async {
  students = await ApiService.getStudents();
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
    try {
      await loadStudents();
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not load students: $error')),
        );
      }
    }
    if (!mounted) return;
    setState(() => isLoading = false);
  }

  Future<void> openAddStudent() async {
    final result = await Navigator.pushNamed(context, '/add-student');

    if (result == true && mounted) {
      await loadStudents();
      if (!mounted) return;
      setState(() {
        sortStudents();
      });
    }
  }

  Future<void> editStudent(Map<String, dynamic> student) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return EditStudentDialog(student: student);
      },
    );

    if (result == true && mounted) {
      try {
        await loadStudents();
        if (mounted) setState(() {});
        if (mounted) {
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

  Future<void> deleteStudent(Map<String, dynamic> student) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Delete Student'),
          content: const Text('Are you sure you want to delete this student?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true && mounted) {
      try {
        await ApiService.deleteStudent(int.parse(student['dbId'].toString()));
        await loadStudents();
        if (mounted) setState(() {});
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Student deleted successfully!')),
          );
        }
      } catch (error) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Delete failed: $error')),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Student List Screen', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            onPressed: openAddStudent,
            icon: const Icon(Icons.person_add, color: Colors.white),
          ),
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onSelected: (value) {
              if (value == 'subjects') Navigator.pushNamed(context, '/subject-list');
              if (value == 'schedule') Navigator.pushNamed(context, '/schedule'); // Added Schedule
              if (value == 'enrollment') Navigator.pushNamed(context, '/enrollment');
              if (value == 'grades') Navigator.pushNamed(context, '/grades');
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(value: 'subjects', child: Text('Manage Subjects')),
                const PopupMenuItem(value: 'schedule', child: Text('Manage Schedules')),
                const PopupMenuItem(value: 'enrollment', child: Text('Enrollment')),
                const PopupMenuItem(value: 'grades', child: Text('Grades')),
              ];
            },
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/flutterimage.jpg'), fit: BoxFit.cover),
        ),
        child: isLoading
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 15),
                    Text('Loading students...', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
                  ],
                ),
              )
            : students.isEmpty
                ? const Center(
                    child: Text('No students found.', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
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
                              student['image'] ?? 'assets/Profile.jpg',
                              width: 350,
                              height: 200,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.person, size: 100, color: Colors.white);
                              },
                            ),
                          ),
                          const SizedBox(height: 15),
                          GestureDetector(
                            onTap: () async {
                              await Navigator.pushNamed(context, '/student-details', arguments: student);
                              if (!mounted) return;
                              await loadStudents();
                              if (!mounted) return;
                              setState(() { sortStudents(); });
                            },
                            child: Card(
                              color: const Color.fromARGB(53, 103, 102, 102),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(student['active'] == true ? Icons.check_circle : Icons.cancel, color: student['active'] == true ? Colors.green : Colors.red, size: 20),
                                        const SizedBox(width: 6),
                                        Text(student['active'] == true ? 'ACTIVE' : 'INACTIVE', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: student['active'] == true ? Colors.green : Colors.red)),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    if (student['active'] != true)
                                      const Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.warning, color: Colors.red, size: 20),
                                          SizedBox(width: 6),
                                          Flexible(child: Text('INACTIVE - Please check status', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold))),
                                        ],
                                      ),
                                    const SizedBox(height: 8),
                                    Text(student['name'] ?? 'Unknown', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 249, 249, 250), shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(1, 1))])),
                                    const SizedBox(height: 15),
                                    Text(student['course'] ?? '', style: const TextStyle(fontSize: 18, color: Colors.white, shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(1, 1))])),
                                    const SizedBox(height: 15),
                                    Text('Age: ${student['age']}', style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic, color: Colors.white, shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(1, 1))])),
                                    const SizedBox(height: 15),
                                    Text(student['hobby'] ?? '', style: const TextStyle(fontSize: 18, color: Colors.white, shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(1, 1))])),
                                    const SizedBox(height: 15),
                                    Text('Student ID: ${student['studentId']}', style: const TextStyle(fontSize: 18, color: Colors.white, shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(1, 1))])),
                                    const SizedBox(height: 10),
                                    Text('Email: ${student['email']}', style: const TextStyle(fontSize: 18, color: Colors.white, shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(1, 1))])),
                                    const SizedBox(height: 10),
                                    Text('Favorite Subject: ${student['favoriteSubject']}', style: const TextStyle(fontSize: 18, color: Colors.white, shadows: [Shadow(blurRadius: 6, color: Colors.black54, offset: Offset(1, 1))])),
                                    const SizedBox(height: 15),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(onPressed: () => editStudent(student), icon: const Icon(Icons.edit, color: Colors.white, size: 40)),
                                        IconButton(onPressed: () => deleteStudent(student), icon: const Icon(Icons.delete, color: Color.fromARGB(255, 255, 90, 90), size: 40)),
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

// ============================================================================
// NEW SEPARATE WIDGET FOR EDITING STUDENT
// ============================================================================

class EditStudentDialog extends StatefulWidget {
  final Map<String, dynamic> student;
  const EditStudentDialog({super.key, required this.student});

  @override
  State<EditStudentDialog> createState() => _EditStudentDialogState();
}

class _EditStudentDialogState extends State<EditStudentDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController nameController;
  late TextEditingController courseController;
  late TextEditingController idController;
  late TextEditingController yearLevelController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student['name']?.toString() ?? '');
    courseController = TextEditingController(text: widget.student['course']?.toString() ?? '');
    idController = TextEditingController(text: widget.student['studentId']?.toString() ?? '');
    yearLevelController = TextEditingController(text: widget.student['yearLevel']?.toString() ?? '1');
  }

  @override
  void dispose() {
    nameController.dispose();
    courseController.dispose();
    idController.dispose();
    yearLevelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Student'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter student name' : null,
              ),
              TextFormField(
                controller: idController,
                decoration: const InputDecoration(labelText: 'Student ID'),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) return 'Enter student ID';
                  final duplicate = students.any((other) {
                    return !identical(other, widget.student) &&
                        other['studentId'].toString().toLowerCase() == value.trim().toLowerCase();
                  });
                  if (duplicate) return 'Student ID already exists';
                  return null;
                },
              ),
              TextFormField(
                controller: courseController,
                decoration: const InputDecoration(labelText: 'Course'),
                validator: (value) => (value == null || value.trim().isEmpty) ? 'Enter course' : null,
              ),
              TextFormField(
                controller: yearLevelController,
                decoration: const InputDecoration(labelText: 'Year Level'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  final year = int.tryParse(value?.trim() ?? '');
                  if (year == null || year < 1 || year > 6) return 'Enter a valid year level (1-6)';
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () async {
            if (_formKey.currentState!.validate()) {
              try {
                await ApiService.updateStudent(
                  dbId: int.parse(widget.student['dbId'].toString()),
                  studentNumber: idController.text.trim(),
                  fullName: nameController.text.trim(),
                  course: courseController.text.trim(),
                  yearLevel: int.parse(yearLevelController.text.trim()),
                  email: widget.student['email']?.toString() ?? '',
                );
                if (context.mounted) Navigator.pop(context, true); // Success
              } catch (error) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Update failed: $error')),
                  );
                }
              }
            }
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}