import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';
import 'attendance_record.dart'; // Import the AttendanceRecord screen

class UserPanel extends StatefulWidget {
  UserPanel({Key? key}) : super(key: key);

  @override
  _UserPanelState createState() => _UserPanelState();
}

class _UserPanelState extends State<UserPanel> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<AttendanceItem> _attendanceList = [];
  late StreamController<DateTime> _streamController;
  late Stream<DateTime> _timeStream;
  late DateTime lastPresentTime;
  late DateTime lastAbsentTime;
  late DateTime lastLeaveTime;

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<DateTime>();
    _timeStream = _streamController.stream;
    _initializeClock();
    // Populate sample attendance records
    _populateAttendanceList();
    // Initialize lastPresentTime
    if (_attendanceList.isNotEmpty) {
      lastPresentTime = _attendanceList.firstWhere((item) => item.present == true)?.dateTime ?? DateTime.now();
    } else {
      lastPresentTime = DateTime.now();
    }

    lastAbsentTime = DateTime.now(); // Initialize as needed
    lastLeaveTime = DateTime.now();
  }

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _populateAttendanceList() {
    // Sample attendance records
    for (int i = 0; i < 10; i++) {
      DateTime timestamp = DateTime.now().subtract(Duration(days: i, hours: i));
      _attendanceList.add(AttendanceItem(
        serialNo: (i + 1).toString(),
        present: i.isEven,
        leave: false,
        dateTime: timestamp,
      ));
    }
  }

  void _initializeClock() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      _streamController.add(DateTime.now());
    });
    print("Clock initialized");
  }

  void _saveAttendanceRecord({required bool present, required bool leave}) {
    DateTime currentTime = DateTime.now();
    DateTime lastRecordedTime;

    if (present) {
      lastRecordedTime = lastPresentTime;
    } else if (leave) {
      lastRecordedTime = lastLeaveTime;
    } else {
      lastRecordedTime = lastAbsentTime;
    }

    if (lastRecordedTime != null && currentTime.difference(lastRecordedTime).inHours >= 24) {
      // If attendance can be recorded
      String serialNo = (_attendanceList.length + 1).toString();

      setState(() {
        _attendanceList.insert(0, AttendanceItem(
          serialNo: serialNo,
          present: present,
          dateTime: DateTime.now(),
          leave: leave,
        ));
      });

      if (present) {
        lastPresentTime = currentTime;
      } else if (leave) {
        lastLeaveTime = currentTime;
      } else {
        lastAbsentTime = currentTime;
      }

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Attendance Marked'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      // If attendance has already been recorded
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Attendance Already Recorded'),
            content: Text('You can record Attendance once in 24 hours'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                      "User Panel",
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
                        left: 58,
                        top: 50,
                        child: StreamBuilder<DateTime>(
                          stream: _timeStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  DateFormat('hh:mm:ss a')
                                      .format(snapshot.data!),
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white),
                                ),
                              );
                            } else {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Clock is not initialized',
                                  style: TextStyle(
                                      fontSize: 35, color: Colors.white),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                      Positioned(
                        bottom: 80,
                        child: Column(
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                _saveAttendanceRecord(
                                    present: true, leave: false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.8,
                                  60,
                                ),
                              ),
                              child: Text('Mark Present'),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () {
                                _saveAttendanceRecord(
                                    present: false, leave: false);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.8,
                                  60,
                                ),
                              ),
                              child: Text('Mark Absent'),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () {
                                _saveAttendanceRecord(
                                    present: false, leave: true);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.8,
                                  60,
                                ),
                              ),
                              child: Text('Mark Leave'),
                            ),
                            SizedBox(height: 20.0),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AttendanceRecord(
                                      attendanceList: _attendanceList,
                                      dateTime: DateTime.now(), // Replace with appropriate value
                                      serialNo: '1', // Replace with appropriate value
                                      present: true, // Replace with appropriate value
                                      leave: false, // Replace with appropriate value
                                      lastPresentTime: DateTime.now(), // Provide a value for lastPresentTime
                                      lastAbsentTime: DateTime.now(), // Provide a value for lastAbsentTime
                                      lastLeaveTime: DateTime.now(),
                                    ),
                                  ),
                                );
                                print('View Attendance');
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue,
                                minimumSize: Size(
                                  MediaQuery.of(context).size.width * 0.8,
                                  60,
                                ),
                              ),
                              child: Text('View Attendance'),
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
    );
  }
}
