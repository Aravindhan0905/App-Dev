import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'FeesPage.dart';
import 'NotesPage.dart';

class AttendancePage extends StatefulWidget {
  const AttendancePage({super.key});

  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  final int _selectedIndex = 1;

  // Dummy Data for Attendance Stats
  final double totalAttendance = 85.0; // Total percentage
  final int totalDaysAttended = 170;
  final int totalDaysMissed = 30;
  final int totalClassDays = 200;
  final String todayStatus = "Attended";

  // Dummy Data for Course-wise Attendance
  final Map<String, double> courseAttendance = {
    'Mathematics': 90.0,
    'Physics': 80.0,
    'Chemistry': 85.0,
    'English': 75.0,
  };

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
        );
        break;
      case 1:
        break; // Stay on AttendancePage
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FeesPage()),
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NotesPage()),
        );
        break;
    }
  }

  Widget _buildAttendanceSummary() {
    return Column(
      children: <Widget>[
        const Text(
          'Total Attendance',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        CircularProgressIndicator(
          value: totalAttendance / 100,
          strokeWidth: 8.0,
          backgroundColor: Colors.grey[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
        ),
        const SizedBox(height: 10),
        Text(
          '$totalAttendance%',
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                const Text(
                  'Total Days',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '$totalClassDays',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const Text(
                  'Days Attended',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '$totalDaysAttended',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Column(
              children: <Widget>[
                const Text(
                  'Days Missed',
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 5),
                Text(
                  '$totalDaysMissed',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Text(
          'Today\'s Attendance: $todayStatus',
          style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: todayStatus == "Attended" ? Colors.green : Colors.red),
        ),
      ],
    );
  }

  Widget _buildCourseAttendance() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Course-wise Attendance',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Column(
          children: courseAttendance.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    entry.key,
                    style: const TextStyle(fontSize: 18),
                  ),
                  Text(
                    '${entry.value}%',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildAttendanceHistory() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const Text(
          'Attendance History',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ListView(
          shrinkWrap: true,
          children: const <Widget>[
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('August 25, 2024'),
              subtitle: Text('Attended'),
            ),
            ListTile(
              leading: Icon(Icons.cancel, color: Colors.red),
              title: Text('August 24, 2024'),
              subtitle: Text('Missed'),
            ),
            ListTile(
              leading: Icon(Icons.check_circle, color: Colors.green),
              title: Text('August 23, 2024'),
              subtitle: Text('Attended'),
            ),
          ],
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
        leading: BackButton(
          color: const Color.fromARGB(255, 0, 0, 0),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _buildAttendanceSummary(),
            const SizedBox(height: 30),
            _buildCourseAttendance(),
            const SizedBox(height: 30),
            _buildAttendanceHistory(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.blue,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Attendance',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money),
            label: 'Fees',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notes),
            label: 'Notes',
          ),
        ],
      ),
    );
  }
}
