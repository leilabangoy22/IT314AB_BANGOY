import 'package:flutter/material.dart';

class Players {
  String? name = "MissYouLikeKrazy";
  String? status = "Online - VALORANT";

  String? name1 = "bread";
  String? status1 = "Playing - VALORANT";

  String? name2 = "The14th";
  String? status2 = "Playing - VALORANT";

  String? online = "Carlvendish";
  String? status3 = "Away - Riot Mobile";

  String? online2 = "D1yah";
  String? status4 = "Away - Riot Mobile";
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Social',
      theme: ThemeData.dark(useMaterial3: true),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Players player = Players();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF090909),
        title: const Text('Social'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 15),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 15),
                const Text('Friends'),
                const SizedBox(width: 15),
                const Text('Messages'),
                const SizedBox(width: 15),
                const Text('Requests'),
              ],
            ),

            const SizedBox(height: 20),

            Container(
              width: 320,
              height: 50,
              decoration: BoxDecoration(
                color: const Color(0xFF211D1F),
                borderRadius: BorderRadius.circular(14),
              ),

              child: const Row(
                children: [
                  SizedBox(width: 15),
                  Icon(Icons.search, color: Colors.white, size: 28),
                  SizedBox(width: 12),
                  Text(
                    'Search',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const SizedBox(width: 20),
                Image.asset(
                  'assets/valorant.png',
                  width: 40,
                  height: 40,
                  fit: BoxFit.cover,
                ),
                const SizedBox(width: 15),
                const Text(
                  'VALORANT 3',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const SizedBox(width: 25),
                const CircleAvatar(
                  radius: 27,
                  backgroundColor: Color(0xFF211D1F),
                  child: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 248, 1, 1),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                    const SizedBox(height: 5),

                    Icon(Icons.monitor),

                    Text(
                      player.status ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const SizedBox(width: 25),
                const CircleAvatar(
                  radius: 27,
                  backgroundColor: Color(0xFF211D1F),
                  child: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 248, 1, 1),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name1 ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      player.status1 ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const SizedBox(width: 25),
                const CircleAvatar(
                  radius: 27,
                  backgroundColor: Color(0xFF211D1F),
                  child: Icon(
                    Icons.person,
                    color: Color.fromARGB(255, 248, 1, 1),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.name2 ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                    const SizedBox(height: 5),

                    Text(
                      player.status2 ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const SizedBox(width: 20),
                const Text(
                  'Online  4',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const SizedBox(width: 25),
                const CircleAvatar(
                  radius: 27,
                  backgroundColor: Color(0xFF211D1F),
                  child: Icon(Icons.person, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.online ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      player.status3 ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                const SizedBox(width: 25),
                const CircleAvatar(
                  radius: 27,
                  backgroundColor: Color(0xFF211D1F),
                  child: Icon(Icons.person, color: Colors.white, size: 28),
                ),
                const SizedBox(width: 15),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      player.online2 ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      player.status4 ?? "Unknown",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color.fromARGB(255, 249, 249, 250),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
