import 'package:flutter/material.dart';

class AdminPanel extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFEEA2A2),
                    Color(0xFFBBC1BF),
                    Color(0xFF57C6E1),
                    Color(0xFFB49FDA),
                    Color(0xFF7AC5D8),
                  ],
                  stops: [0.0, 0.19, 0.42, 0.79, 1.0],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    heightFactor: 4,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Admin Panel",
                        style: TextStyle(
                          fontFamily: 'poppins',
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          bottom: 80,
                          child: Column(
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Logic to view all records
                                  print('View All Records');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    60,
                                  ),
                                ),
                                child: Text('View All Records',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Logic to edit attendance
                                  print('Edit Attendance');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    60,
                                  ),
                                ),
                                child: Text('Edit Attendance',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Logic to generate user attendance report
                                  print('Generate User Attendance Report');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    60,
                                  ),
                                ),
                                child: Text('User Attendance Report',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  // Logic for leave approval
                                  print('Leave Approval');
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.lightBlue,
                                  minimumSize: Size(
                                    MediaQuery.of(context).size.width * 0.8,
                                    60,
                                  ),
                                ),
                                child: Text('Leave Approval',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              left: 10,
              child: GestureDetector(
                onTap: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.menu,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color(0xFF57C6E1),
                ),
                child: Container(
                  height: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage:
                            AssetImage('assets/profile_picture.jpg'),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Abdul Karim',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'Mobile: 123-456-7890',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        'abdulkarimtwk@gmail.com',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ListTile(
                title: Text('About'),
                onTap: () {
                  print('About');
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text('Log out'),
                onTap: () {
                  print('Log out');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
