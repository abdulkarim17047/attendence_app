import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AttendanceRecord extends StatelessWidget {
  final String serialNo;
  final bool present;
  final bool leave;
  final DateTime dateTime;
  DateTime lastPresentTime;
  DateTime lastAbsentTime;
  DateTime lastLeaveTime;

  final List<AttendanceItem> attendanceList;

  AttendanceRecord({
    required this.dateTime,
    required this.serialNo,
    required this.present,
    required this.attendanceList,
    required this.leave,
    required this.lastPresentTime,
    required this.lastAbsentTime,
    required this.lastLeaveTime,
  });

  String getFormattedDateTime() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final filteredAttendanceList = attendanceList.where((item) {
      if (present) {
        return item.present;
      } else {
        return !item.present || item.leave;
      }
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance Record'),
      ),
      body: ListView.builder(
        itemCount: attendanceList.length,
        itemBuilder: (context, index) {
          var attendanceItem = attendanceList[index];
          return ListTile(
            leading: Text(attendanceItem.serialNo),
            title: Text(_getStatusText(attendanceItem)),
            subtitle: Text(
              'Date: ${DateFormat('yyyy-MM-dd').format(
                  attendanceItem.dateTime)}\nTime: ${DateFormat('HH:mm:ss')
                  .format(attendanceItem.dateTime)}',
            ),
          );
        },
      ),
    );
  }

  String _getStatusText(AttendanceItem attendanceItem) {
    if (attendanceItem.present) {
      return 'Present';
    } else if (attendanceItem.leave) {
      return 'Leave';
    } else {
      return 'Absent';
    }
  }
}

class AttendanceItem {
  final String serialNo;
  final bool present;
  final DateTime dateTime;
  final bool leave;

  AttendanceItem({
    required this.serialNo,
    required this.present,
    required this.dateTime,
    required this.leave,
  });
}

class UserPanel extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<AttendanceItem> _attendanceList = [];

  UserPanel({Key? key}) : super(key: key) {
    _populateAttendanceList();
  }

  void _populateAttendanceList() {
    for (int i = 0; i < 10; i++) {
      _attendanceList.add(AttendanceItem(
        serialNo: (i + 1).toString(),
        present: i.isEven,
        leave: i % 3 == 0, // Assume every third record is on leave
        dateTime: DateTime.now().subtract(Duration(days: i)),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ListView.builder(
        itemCount: _attendanceList.length,
        itemBuilder: (context, index) {
          var attendanceItem = _attendanceList[index];
          return ListTile(
            title: Text('Attendance Record ${attendanceItem.serialNo}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AttendanceRecord(
                    dateTime: attendanceItem.dateTime,
                    serialNo: attendanceItem.serialNo,
                    present: attendanceItem.present,
                    attendanceList: _attendanceList,
                    leave: attendanceItem.leave,
                    lastPresentTime: DateTime.now(), // Provide appropriate value
                    lastAbsentTime: DateTime.now(), // Provide appropriate value
                    lastLeaveTime: DateTime.now(),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
