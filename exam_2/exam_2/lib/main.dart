import 'package:flutter/material.dart';

class Player {
  String? name;
  String? status;
  bool isOnline;
  bool isMobile;

  Player({
    this.name,
    this.status,
    this.isOnline = false,
    this.isMobile = false,
  });
}

class Players {
  List<Player> players = [
    Player(
      name: "MissYouLikeKrazy",
      status: "Online - VALORANT",
      isOnline: true,
      isMobile: false,
    ),
    Player(
      name: "bread",
      status: "Playing - VALORANT",
      isOnline: true,
      isMobile: false,
    ),
    Player(
      name: "The14th",
      status: "Playing - VALORANT",
      isOnline: true,
      isMobile: false,
    ),
    Player(
      name: "Carlvendish",
      status: "Away - Riot Mobile",
      isOnline: false,
      isMobile: true,
    ),
    Player(
      name: "D1yah",
      status: "Away - Riot Mobile",
      isOnline: false,
      isMobile: true,
    ),
  ];
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

            Expanded(
              child: ListView.builder(
                itemCount: player.players.length,
                itemBuilder: (context, index) {
                  Player currentPlayer = player.players[index];

                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ChatRoom(player: currentPlayer);
                          },
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Row(
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
                                currentPlayer.name ?? "Unknown User",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 249, 249, 250),
                                ),
                              ),

                              Row(
                                children: [
                                  Icon(
                                    currentPlayer.isMobile
                                        ? Icons.mobile_friendly
                                        : Icons.monitor,
                                    size: 20,
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    currentPlayer.status ??
                                        "No status available.",
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
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ChatRoom extends StatefulWidget {
  final Player player;

  const ChatRoom({super.key, required this.player});

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,

      appBar: AppBar(
        backgroundColor: const Color(0xFF090909),

        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundColor: Color(0xFF211D1F),
              child: Icon(
                Icons.person,
                color: Color.fromARGB(255, 248, 1, 1),
                size: 22,
              ),
            ),

            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.player.name ?? "Unknown User",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                Text(
                  widget.player.status ?? "No status available.",
                  style: const TextStyle(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    messageController.dispose();
    super.dispose();
  }
}
