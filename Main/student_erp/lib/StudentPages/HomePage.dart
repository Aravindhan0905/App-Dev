import 'package:flutter/material.dart';
import 'package:student_erp/StudentPages/HomePage.dart';
import 'package:student_erp/StudentPages/LoginPage.dart';
import 'package:student_erp/StudentPages/AttendancePage.dart';
import 'package:student_erp/StudentPages/FeesPage.dart';
import 'package:student_erp/StudentPages/NotesPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        // Staying on HomePage, no action needed
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendancePage()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const FeesPage()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const NotesPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.account_circle),
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
            const UserAccountsDrawerHeader(
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
            const ListTile(
              title: Text("Personal Details",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const ListTile(
              title: Text("Father's Name: Mr. XYZ"),
            ),
            const ListTile(
              title: Text("Mother's Name: Mrs. ABC"),
            ),
            const ListTile(
              title: Text("Email ID: student.email@example.com"),
            ),
            const ListTile(
              title: Text("Father's Phone: 1234567890"),
            ),
            const ListTile(
              title: Text("Mother's Phone: 6365248926"),
            ),
            const ListTile(
              title: Text("Father's Occupation: Engineer"),
            ),
            const ListTile(
              title: Text("Mother's Occupation: Teacher"),
            ),
            const ListTile(
              title: Text("Mentor's Name: Dr. John Doe"),
            ),
            const ListTile(
              title: Text("Mentor's Phone: 0987654321"),
            ),
            const Divider(),
            ListTile(
              title: const Text("Logout"),
              trailing: const Icon(Icons.logout),
              onTap: () {
                // Handle logout logic here
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          const LoginPage()), // Redirects to the LoginPage
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
            const Row(
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
            const SizedBox(height: 20),
            const Text(
              'Circulars & Events',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: const <Widget>[
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
