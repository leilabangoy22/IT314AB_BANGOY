import 'package:flutter/material.dart';

final List<Map<String, dynamic>> students = [
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
  students.sort((a, b) => a['name'].toString().compareTo(b['name'].toString()));
}

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
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
            onPressed: () {
              Navigator.pushNamed(context, '/add-student');
            },
            icon: const Icon(Icons.person_add, color: Colors.white),
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
            : ListView(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: students.length,
                    itemBuilder: (context, index) {
                      final student = students[index];

                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Image.asset(
                              student['image'],
                              width: 350,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 15),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/student-details',
                                arguments: student,
                              );
                            },
                            child: Card(
                              color: const Color.fromARGB(53, 103, 102, 102),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          student['active']
                                              ? Icons.check_circle
                                              : Icons.cancel,
                                          color: student['active']
                                              ? Colors.green
                                              : Colors.red,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          student['active']
                                              ? 'ACTIVE'
                                              : 'INACTIVE',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: student['active']
                                                ? Colors.green
                                                : Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),

                                    if (!student['active'])
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.warning,
                                            color: Colors.red,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 6),
                                          const Text(
                                            'INACTIVE - Please check status',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
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
                                      student['course'],
                                      style: const TextStyle(
                                        fontSize: 18,
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
                                      'Age: ${student['age']}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontStyle: FontStyle.italic,
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
                                      student['hobby'],
                                      style: const TextStyle(
                                        fontSize: 18,
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
                                      'Student ID: ${student['studentId']}',
                                      style: const TextStyle(
                                        fontSize: 18,
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

                                    const SizedBox(height: 10),

                                    Text(
                                      'Email: ${student['email']}',
                                      style: const TextStyle(
                                        fontSize: 18,
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

                                    const SizedBox(height: 10),

                                    Text(
                                      'Favorite Subject: ${student['favoriteSubject']}',
                                      style: const TextStyle(
                                        fontSize: 18,
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

                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        // EDIT REMAINS A MODAL
                                        IconButton(
                                          onPressed: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    'Edit Student',
                                                  ),
                                                  content: Text(
                                                    'Edit screen for '
                                                    '${student['name']} '
                                                    'coming soon!',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Close',
                                                      ),
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                          },
                                          icon: const Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                            size: 40,
                                          ),
                                        ),

                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              students.remove(student);
                                            });
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

                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}
