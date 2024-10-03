import 'package:flutter/material.dart';
import 'package:student_erp/StudentPages/LoginPage.dart';
import 'AttendancePage.dart';
import 'FeesPage.dart';
import 'NotesPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        // Staying on HomePage, no action needed
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AttendancePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FeesPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => NotesPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                Scaffold.of(context)
                    .openEndDrawer(); // Opens the sliding drawer
              },
            ),
          ),
        ],
      ),
      endDrawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName:
                  Text("Student Name"), // Replace with actual student name
              accountEmail: Text(
                  "student.email@example.com"), // Replace with actual email
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage(
                    "assets/sakthivel.jpg"), // Replace with actual image
              ),
              decoration: BoxDecoration(
                color: Colors.blue, // The background color of the drawer header
              ),
            ),
            ListTile(
              title: Text("Personal Details",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              title: Text("Father's Name: Mr. XYZ"),
            ),
            ListTile(
              title: Text("Mother's Name: Mrs. ABC"),
            ),
            ListTile(
              title: Text("Email ID: student.email@example.com"),
            ),
            ListTile(
              title: Text("Father's Phone: 1234567890"),
            ),
            ListTile(
              title: Text("Mother's Phone: 6365248926"),
            ),
            ListTile(
              title: Text("Father's Occupation: Engineer"),
            ),
            ListTile(
              title: Text("Mother's Occupation: Teacher"),
            ),
            ListTile(
              title: Text("Mentor's Name: Dr. John Doe"),
            ),
            ListTile(
              title: Text("Mentor's Phone: 0987654321"),
            ),
            Divider(),
            ListTile(
              title: Text("Logout"),
              trailing: Icon(Icons.logout),
              onTap: () {
                // Handle logout logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          LoginPage()), // Redirects to the LoginPage
                );
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage(
                      "assets/sakthivel.jpg"), // Replace with actual image
                ),
                SizedBox(width: 20),
                Text(
                  'Student Name', // Replace with actual student name
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Circulars & Events',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      title: Text('Event 1'),
                      subtitle: Text('Details about event 1'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Event 2'),
                      subtitle: Text('Details about event 2'),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text('Event 3'),
                      subtitle: Text('Details about event 3'),
                    ),
                  ),
                ],
              ),
            ),
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
