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
    'favorite': false,
    'editing': false,
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
    'favorite': false,
    'editing': false,
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
    'favorite': false,
    'editing': false,
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
    'favorite': false,
    'editing': false,
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
    'favorite': false,
    'editing': false,
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
    'favorite': false,
    'editing': false,
  },
];

void sortStudents() {
  students.sort(
    (a, b) => a['name'].toString().compareTo(
      b['name'].toString(),
    ),
  );
}

String name = "Leila G. Bangoy";
String courseSection = "BSIT - 3";
int age = 20;
double height = 5.0;
bool isStudent = true;

String profileImage = 'assets/Profile.jpg';

String favgame = "Baseball";
String favfood = "Buffalo Chicken";
String favmovie = "Blind Side";
String music = "All Taylor Swift Song";
String hobby = "Watching Movies";

String name2 = "Karol S. Pal";
String courseSection2 = "BSIT - 3";
int age2 = 20;
double height2 = 5.1;
bool isStudent2 = true;
String hobby2 = "Sleeping";

String profileImage2 = 'assets/Profile2.jpg';

String name3 = "Shairha May Ejares";
String courseSection3 = "BSIT - 3";
int age3 = 20;
double height3 = 4.8;
bool isStudent3 = true;
String hobby3 = "Unknown";

String profileImage3 = 'assets/Profile3.jpg';

String name4 = "Cassandra Gayle R. Oraiz";
String courseSection4 = "Unknown";
int age4 = 20;
double height4 = 4.9;
bool isStudent4 = true;
String hobby4 = "Drawing";

String profileImage4 = 'assets/Profile4.jpg';

String name5 = "James Neil Maano";
String courseSection5 = "BSIT - 3";
int age5 = 20;
double height5 = 5.2;
bool isStudent5 = true;
String hobby5 = "Not Provided";

String profileImage5 = 'assets/Profile5.jpg';

void main() {
  sortStudents();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlue,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'My First Flutter Application',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: double.infinity,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              'assets/flutterimage.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),

        child: students.isEmpty
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
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: students.length,

                    itemBuilder: (context, index) {
                      final student = students[index];

                      return Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 20),

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
                              print(
                                'Student Card tapped: ${student['name']}',
                              );
                            },

                            child: Card(
                              // FLAG 4: card color changes when favorited
                              color: student['favorite']
                                  ? const Color.fromARGB(
                                      120,
                                      59,
                                      115,
                                      236,
                                    )
                                  : const Color.fromARGB(
                                      53,
                                      103,
                                      102,
                                      102,
                                    ),

                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(12),
                                side: student['favorite']
                                    ? const BorderSide(
                                        color: Color.fromARGB(
                                          255,
                                          59,
                                          115,
                                          236,
                                        ),
                                        width: 2,
                                      )
                                    : BorderSide.none,
                              ),

                              child: Padding(
                                padding: const EdgeInsets.all(15),

                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,

                                  children: [
                                    // FLAG 4: "Favorite" label, only shown when marked
                                    if (student['favorite']) ...[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.star,
                                            color: Color.fromARGB(
                                              255,
                                              255,
                                              215,
                                              0,
                                            ),
                                            size: 20,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            'FAVORITE',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight:
                                                  FontWeight.bold,
                                              letterSpacing: 1.2,
                                              color: Color.fromARGB(
                                                255,
                                                255,
                                                215,
                                                0,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 8),
                                    ],

                                    Text(
                                      student['name'],
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
                                        // FAVORITE BUTTON
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              student['favorite'] =
                                                  !student['favorite'];
                                            });
                                          },

                                          icon: Icon(
                                            student['favorite']
                                                ? Icons.favorite
                                                : Icons.favorite_border,
                                            color: student['favorite']
                                                ? const Color.fromARGB(
                                                    255,
                                                    59,
                                                    115,
                                                    236,
                                                  )
                                                : Colors.white,
                                            size: 40,
                                          ),
                                        ),

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
                                                        Navigator.pop(
                                                          context,
                                                        );
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

                  // =========================
                  // FAVORITES ICON
                  // =========================

                  IconButton(
                    onPressed: () {
                      setState(() {
                        isFavorite = !isFavorite;
                      });
                    },

                    icon: Icon(
                      Icons.favorite,
                      color: isFavorite
                          ? const Color.fromARGB(
                              255,
                              59,
                              115,
                              236,
                            )
                          : Colors.white,
                      size: 200,
                    ),
                  ),

                  // =========================
                  // FAVORITES CARD
                  // =========================

                  Card(
                    color: const Color.fromARGB(
                      53,
                      134,
                      133,
                      133,
                    ),

                    child: Padding(
                      padding: const EdgeInsets.all(15),

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          const SizedBox(height: 10),

                          const Text(
                            'My Favorites',
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(
                                255,
                                253,
                                253,
                                253,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          const Text(
                            'Favorite Game: Baseball',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(
                                255,
                                253,
                                253,
                                253,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            'Favorite Food: Buffalo Chicken',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(
                                255,
                                253,
                                253,
                                253,
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          const Text(
                            'Favorite Movie: Blind Side',
                            style: TextStyle(
                              fontSize: 18,
                              color: Color.fromARGB(
                                255,
                                253,
                                253,
                                253,
                              ),
                            ),
                          ),

                          const SizedBox(height: 15),

                          Row(
                            mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,

                            children: const [
                              Text(
                                'Music: All Taylor Swift',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(
                                    255,
                                    253,
                                    253,
                                    253,
                                  ),
                                ),
                              ),

                              Text(
                                'Hobby: Watching Movies',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Color.fromARGB(
                                    255,
                                    253,
                                    253,
                                    253,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
      ),
    );
  }
}