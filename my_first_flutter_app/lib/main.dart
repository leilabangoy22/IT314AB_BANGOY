import 'package:flutter/material.dart';
import 'student_list_screen.dart';
import 'student_details_screen.dart';
import 'add_student_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await loadStudents();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/student-list',
      routes: {
        '/student-list': (context) => const StudentListScreen(),
        '/student-details': (context) {
          final student =
              ModalRoute.of(context)!.settings.arguments
                  as Map<String, dynamic>;

          return StudentDetailsScreen(student: student);
        },
        '/add-student': (context) => const AddStudentScreen(),
      },
    );
  }
}