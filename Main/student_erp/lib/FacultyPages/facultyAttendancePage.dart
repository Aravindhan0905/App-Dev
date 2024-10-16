import 'package:flutter/material.dart';

void main() {
  runApp(FacultyPage());
}

class FacultyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Faculty Dashboard'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                // Add profile functionality here
              },
            ),
          ],
        ),
        body: FacultyDashboard(),
      ),
    );
  }
}

class FacultyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Student Dashboard
            DashboardCard(
              title: 'Students Dashboard',
              widgets: [
                StatWidget(
                    label: 'Total Present',
                    count: 400,
                    countColor: Colors.green),
                StatWidget(
                    label: 'Total Absent', count: 50, countColor: Colors.red),
                StatWidget(
                    label: 'Total On Duty',
                    count: 20,
                    countColor: Colors.orange),
              ],
              onMoreDetailsPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YearSelectionPage()),
                );
              },
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// Year Selection Page for Student Attendance Details
class YearSelectionPage extends StatelessWidget {
  final List<String> years = ['1st Year', '2nd Year', '3rd Year', '4th Year'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Year'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ListTile(
                title: Text(years[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SectionSelectionPage(year: years[index]),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Section Selection Page
class SectionSelectionPage extends StatelessWidget {
  final String year;
  final List<String> sections = ['Section A', 'Section B', 'Section C'];

  SectionSelectionPage({required this.year});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Section for $year'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              child: ListTile(
                title: Text(sections[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SectionDashboard(
                        year: year,
                        section: sections[index],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

// Section Dashboard for displaying Present, Absent, On Duty for the selected section
class SectionDashboard extends StatefulWidget {
  final String year;
  final String section;

  SectionDashboard({required this.year, required this.section});

  @override
  _SectionDashboardState createState() => _SectionDashboardState();
}

class _SectionDashboardState extends State<SectionDashboard> {
  List<Map<String, dynamic>> students = [
    {
      'name': 'John Doe',
      'rollNo': '101',
      'attendance': ['P', 'A', 'P', 'OD', 'P', 'P', 'P', 'A'], // 8 periods
    },
    {
      'name': 'Jane Smith',
      'rollNo': '102',
      'attendance': ['P', 'P', 'P', 'P', 'OD', 'P', 'A', 'P'], // 8 periods
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.year} - ${widget.section} Attendance Dashboard'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous page
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Edit Attendance for ${widget.section} of ${widget.year}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              DataTable(
                columns: [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Roll No')),
                  // Create 8 columns for 8 periods
                  for (int i = 1; i <= 8; i++) DataColumn(label: Text('P$i')),
                ],
                rows: students.map((student) {
                  int index =
                      students.indexOf(student); // Get the index of the student
                  return DataRow(
                    cells: [
                      DataCell(Text(student['name'])),
                      DataCell(Text(student['rollNo'])),
                      for (int i = 0; i < 8; i++)
                        DataCell(
                          Row(
                            children: ['P', 'A', 'OD'].map((status) {
                              return Expanded(
                                child: Radio<String>(
                                  value: status,
                                  groupValue: student['attendance'][i],
                                  onChanged: (newStatus) {
                                    setState(() {
                                      students[index]['attendance'][i] =
                                          newStatus!;
                                    });
                                  },
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                    ],
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Save the updated attendance data
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Attendance Updated')),
                  );
                },
                child: Text('Save Attendance'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Reusable DashboardCard Widget
class DashboardCard extends StatelessWidget {
  final String title;
  final List<Widget> widgets;
  final VoidCallback? onMoreDetailsPressed;

  DashboardCard(
      {required this.title, required this.widgets, this.onMoreDetailsPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widgets,
            ),
            if (onMoreDetailsPressed != null) SizedBox(height: 10),
            if (onMoreDetailsPressed != null)
              ElevatedButton(
                onPressed: onMoreDetailsPressed,
                child: Text('More Details'),
              ),
          ],
        ),
      ),
    );
  }
}

// Reusable StatWidget for displaying Present, Absent, On Duty
class StatWidget extends StatelessWidget {
  final String label;
  final int count;
  final Color countColor;

  StatWidget(
      {required this.label, required this.count, required this.countColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$count',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: countColor),
        ),
        Text(label),
      ],
    );
  }
}