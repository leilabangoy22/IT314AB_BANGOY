import 'package:flutter/material.dart';

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
                Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                 padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                profileImage,
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

             SizedBox(height: 15),

              Card(
                color: const Color.fromARGB(53, 103, 102, 102),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        name,
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
                        courseSection,
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
                         'Height: $height',
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
                   'Student: $isStudent',
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
                        'August 13, 2026',
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
                            'Age: $age',
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
                  // FIRST CARD - PROFILE 2
                 // =========================
                Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                 padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                profileImage2,
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

             SizedBox(height: 15),

              Card(
                color: const Color.fromARGB(53, 103, 102, 102),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        name2,
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
                        courseSection2,
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
                         'Height: $height2',
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
                   'Student: $isStudent2',
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
                        hobby2,
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
                            'Age: $age2',
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

                        ]
                  ),
                ),
              ),

              SizedBox(height: 20),

              

                // =========================
                  // FIRST CARD - PROFILE 3
                 // =========================
                Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                 padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                profileImage3,
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

             SizedBox(height: 15),

              Card(
                color: const Color.fromARGB(53, 103, 102, 102),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        name3,
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
                        courseSection3,
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
                         'Height: $height3',
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
                   'Student: $isStudent3',
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
                        hobby3,
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
                            'Age: $age3',
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

                        ]
                  ),
                ),
              ),

              SizedBox(height: 20),

                // =========================
                  // FIRST CARD - PROFILE 4
                 // =========================
                Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                 padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                profileImage4,
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

             SizedBox(height: 15),

              Card(
                color: const Color.fromARGB(53, 103, 102, 102),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        name4,
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
                        courseSection4,
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
                         'Height: $height4',
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
                   'Student: $isStudent4',
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
                        hobby4,
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
                            'Age: $age4',
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

                        ]
                  ),
                ),
              ),

              SizedBox(height: 20),

                // =========================
                  // FIRST CARD - PROFILE 5
                 // =========================
                Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                 padding: EdgeInsets.only(top: 20),
                child: Image.asset(
                profileImage5,
                width: 350,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),

             SizedBox(height: 15),

              Card(
                color: const Color.fromARGB(53, 103, 102, 102),
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Text(
                        name5,
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
                        courseSection5,
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
                         'Height: $height5',
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
                   'Student: $isStudent5',
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
                        hobby5,
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
                            'Age: $age5',
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

                        ]
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
          size: 200,
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
          favgame,
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
          favfood,
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
          favmovie,
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
              music,
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
              hobby,
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
            ], 
), 
        ),
            ]
      ),
        ),
       ]
      ),
        ),
       ]
      ),
        ),
       ]
      ),
        ),
      ),
);
  }
}