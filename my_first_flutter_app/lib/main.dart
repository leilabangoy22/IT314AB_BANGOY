import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My First Flutter Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
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
        backgroundColor: Colors.blue,
        title: const Text(
          'My First Flutter Application',
          style: TextStyle(color: Colors.white),
        ),
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              // =========================
              // FIRST CARD - PROFILE
              // =========================

              Card(
                color: const Color.fromARGB(53, 103, 102, 102),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        'Leila G. Bangoy',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 249, 249, 250),
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        'BSIT - 3',
                        style: TextStyle(
                          fontSize: 18,
                color: const Color.fromARGB(255, 249, 249, 250),
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        'My First Flutter Application',
                        style: TextStyle(
                          fontSize: 18,
                          fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 249, 249, 250),
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        'August 11, 2026',
                        style: TextStyle(
                          fontSize: 18,
                color: const Color.fromARGB(255, 249, 249, 250),
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),

                      Text(
                        'I Love Watching Movies and Dramas',
                        style: TextStyle(
                          fontSize: 20,
                          fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 249, 249, 250),
                          shadows: [
                            Shadow(
                              blurRadius: 6,
                              color: Colors.black54,
                              offset: Offset(1, 1),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 15),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Text(
                            'Age: 20',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 249, 249, 250),
                              shadows: [
                                Shadow(
                                  blurRadius: 6,
                                  color: Colors.black54,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: 15),

                          Text(
                            'Birthdate: August 22, 2005',
                            style: TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                color: const Color.fromARGB(255, 249, 249, 250),
                              shadows: [
                                Shadow(
                                  blurRadius: 6,
                                  color: Colors.black54,
                                  offset: Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

          // =========================
          // SECOND CARD - FAVORITES
          // =========================

          Icon(
          Icons.favorite,
                color: const Color.fromARGB(255, 249, 249, 250),
          size: 250,
        ),

        Card(
         color: const Color.fromARGB(53, 103, 102, 102),
         child: Padding(
         padding: EdgeInsets.all(15),
         child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         children: [


        SizedBox(height: 10),

        Text(
          'My Favorites',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 249, 249, 250),
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black54,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),

        SizedBox(height: 15),

        Text(
          'Favorite Game: Baseball',
          style: TextStyle(
            fontSize: 18,
                color: const Color.fromARGB(255, 249, 249, 250),
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black54,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),

        SizedBox(height: 10),

        Text(
          'Favorite Food: Buffalo Chicken',
          style: TextStyle(
            fontSize: 18,
                color: const Color.fromARGB(255, 249, 249, 250),
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black54,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),

        SizedBox(height: 10),

        Text(
          'Favorite Movie: Blind Side',
          style: TextStyle(
            fontSize: 18,
                color: const Color.fromARGB(255, 249, 249, 250),
            shadows: [
              Shadow(
                blurRadius: 6,
                color: Colors.black54,
                offset: Offset(1, 1),
              ),
            ],
          ),
        ),

        SizedBox(height: 15),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            Text(
              'Music: All Taylor Swift',
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 249, 249, 250),
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),

            Text(
              'Hobby: Watching Movies',
              style: TextStyle(
                fontSize: 16,
                color: const Color.fromARGB(255, 249, 249, 250),
                shadows: [
                  Shadow(
                    blurRadius: 6,
                    color: Colors.black54,
                    offset: Offset(1, 1),
                  ),
                ],
              ),
            ),
          ],
        ),
                ],
            ), 
          ), 
        ), 
      ],
    ), 
  ), 
), 
); 
  }
}