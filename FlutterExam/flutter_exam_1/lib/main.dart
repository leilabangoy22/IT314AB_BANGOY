import 'package:flutter/material.dart';

String name = "Scyn4pse";
int rank = 261;
int scoreD = 23;
int scoreK = 21;
int scoreA = 6;

String profileImage = 'assets/phoenix.webp';

String name2 = "Joshua";
int rank2 = 190;
int scoreD2 = 17;
int scoreK2 = 21;
int scoreA2 = 8;

String profileImage2 = 'assets/sova.webp';

String name3 = "Dabid";
int rank3 = 89;
int scoreD3 = 9;
int scoreK3 = 8;
int scoreA3 = 1;

String profileImage3 = 'assets/chamber.webp';

String name4 = "Cass";
int rank4 = 298;
int scoreD4 = 28;
int scoreK4 = 23;
int scoreA4 = 6;

String profileImage4 = 'assets/clove.webp';

String name5 = "noobsaur";
int rank5 = 259;
int scoreD5 = 21;
int scoreK5 = 21;
int scoreA5 = 10;

String profileImage5 = 'assets/reyna.webp';

String name6 = "tlbvay";
int rank6 = 219;
int scoreD6 = 20;
int scoreK6 = 18;
int scoreA6 = 5;

String profileImage6 = 'assets/sova.webp';

String name7 = "Kreaiz";
int rank7 = 191;
int scoreD7 = 18;
int scoreK7 = 21;
int scoreA7 = 2;

String profileImage7 = 'assets/reyna.webp';

String name8 = "TranHoang17";
int rank8 = 203;
int scoreD8 = 19;
int scoreK8 = 19;
int scoreA8 = 4;

String profileImage8 = 'assets/raze.webp';

String name9 = "Neithl";
int rank9 = 246;
int scoreD9 = 23;
int scoreK9 = 21;
int scoreA9 = 5;

String profileImage9 = 'assets/cypher.webp';

String name0 = "cluch bus cuk";
int rank0 = 159;
int scoreD0 = 13;
int scoreK0 = 19;
int scoreA0 = 9;

String profileImage0 = 'assets/brimstone.webp';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '<   Match Details',
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: const Color.fromARGB(0, 0, 0, 0)),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        title: const Text(
          '<   Match Details',
          style: TextStyle(color: Color.fromARGB(255, 253, 253, 253)),
        ),
      ),

      body: Container(
        width: double.infinity,
        height: 200,

        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/ascent.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
