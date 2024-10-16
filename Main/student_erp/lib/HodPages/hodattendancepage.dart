import 'package:flutter/material.dart';
import 'dart:io';
// To get a valid file directory
import 'package:csv/csv.dart'; // To generate CSV data

void main() {
  runApp(HodPage());
}

class HodPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('HOD Dashboard'),
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
        body: HodDashboard(),
      ),
    );
  }
}

class HodDashboard extends StatelessWidget {
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
                  countColor: Colors.green,
                  onStatClicked: () {},
                ),
                StatWidget(
                  label: 'Total Absent',
                  count: 50,
                  countColor: Colors.red,
                  onStatClicked: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AbsenteesPage(
                          absentees: [
                            {'name': 'John Doe', 'rollNo': '101'},
                            {'name': 'Jane Smith', 'rollNo': '102'},
                          ],
                        ),
                      ),
                    );
                  },
                ),
                StatWidget(
                  label: 'Total On Duty',
                  count: 20,
                  countColor: Colors.orange,
                  onStatClicked: () {},
                ),
              ],
              onMoreDetailsPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => YearSelectionPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AbsenteesPage extends StatelessWidget {
  final List<Map<String, String>> absentees;

  AbsenteesPage({required this.absentees});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absent Students'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: absentees.length,
        itemBuilder: (context, index) {
          final student = absentees[index];
          return ListTile(
            title: Text(student['name']!),
            subtitle: Text('Roll No: ${student['rollNo']}'),
          );
        },
      ),
    );
  }
}

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
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: years.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(years[index]),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SectionSelectionPage(year: years[index]),
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
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView.builder(
        itemCount: sections.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
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
                        students: List.generate(60, (index) {
                          return {
                            'name': 'Student ${index + 1}',
                            'regNo': 'REG${index + 1}',
                            'mentor': 'Mentor ${index % 5 + 1}',
                            'phone': '123456789${index % 10}',
                            'daysPresent': 90 - (index % 10),
                            'daysAbsent': (index % 10),
                          };
                        }),
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

class SectionDashboard extends StatefulWidget {
  final String year;
  final String section;
  final List<Map<String, dynamic>> students;

  SectionDashboard({required this.year, required this.section, required this.students});

  @override
  _SectionDashboardState createState() => _SectionDashboardState();
}

class _SectionDashboardState extends State<SectionDashboard> {
  DateTime selectedDate = DateTime.now();

  // Function to get attendance for the selected date.
  List<Map<String, dynamic>> getAttendanceForDate(DateTime date) {
    return widget.students.map((student) {
      // Random logic to decide attendance based on student's regNo length (for demo purposes)
      final isAbsent = (date.day + student['regNo'].length) % 5 == 0;
      final isOnDuty = (date.day + student['regNo'].length) % 7 == 0;
      return {
        ...student,
        'isAbsent': isAbsent,
        'isOnDuty': isOnDuty && !isAbsent, // Ensure not both absent and on duty
        'isPresent': !isAbsent && !isOnDuty,
      };
    }).toList();
  }

  // Function to generate CSV data for the attendance
  Future<void> generateCsvFile(List<Map<String, dynamic>> attendance) async {
    List<List<String>> rows = [
      ["Name", "Register Number", "Status"], // Header
    ];

    for (var student in attendance) {
      String status = student['isPresent']
          ? "Present"
          : student['isAbsent']
              ? "Absent"
              : "On Duty";
      rows.add([student['name'], student['regNo'], status]);
    }

    String csvData = const ListToCsvConverter().convert(rows);
    
    // Get a valid file path to save the CSV
    final directory = await getExternalStorageDirectory();
    final path = "${directory!.path}/attendance_${selectedDate.toLocal()}.csv";
    final file = File(path);

    await file.writeAsString(csvData);

    // Show a message or any other indication that the file was downloaded successfully
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text('Attendance CSV downloaded at $path'),
    ));
  }

  @override
  Widget build(BuildContext context) {
    final todayAttendance = getAttendanceForDate(selectedDate);

    return Scaffold(
      appBar: AppBar(
        title: Text('Section: ${widget.section}, ${widget.year}'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );

              if (pickedDate != null && pickedDate != selectedDate) {
                setState(() {
                  selectedDate = pickedDate;
                });
              }
            },
          ),
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () async {
              // Trigger the CSV file download
              await generateCsvFile(todayAttendance);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Attendance for: ${selectedDate.toLocal()}".split(' ')[0],
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: DashboardCard(
                title: 'Attendance Summary',
                widgets: [
                  StatWidget(
                    label: 'Present',
                    count: todayAttendance.where((student) => student['isPresent']).length,
                    countColor: Colors.green,
                    onStatClicked: () {},
                  ),
                  StatWidget(
                    label: 'Absent',
                    count: todayAttendance.where((student) => student['isAbsent']).length,
                    countColor: Colors.red,
                    onStatClicked: () {},
                  ),
                  StatWidget(
                    label: 'On Duty',
                    count: todayAttendance.where((student) => student['isOnDuty']).length,
                    countColor: Colors.orange,
                    onStatClicked: () {},
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: todayAttendance.length,
              itemBuilder: (context, index) {
                final student = todayAttendance[index];

                // Set color based on attendance status
                Color studentColor;
                if (student['isPresent']) {
                  studentColor = Colors.green;
                } else if (student['isAbsent']) {
                  studentColor = Colors.red;
                } else {
                  studentColor = Colors.orange;
                }

                return ListTile(
                  title: Text(
                    '${student['name']} (Reg: ${student['regNo']})',
                    style: TextStyle(color: studentColor), // Color based on status
                  ),
                  subtitle: Text('Mentor: ${student['mentor']}, Phone: ${student['phone']}'),
                  trailing: IconButton(
                    icon: Icon(Icons.info),
                    onPressed: () {
                      // Display more student details in a dialog
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Student Information'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text('Name: ${student['name']}'),
                                Text('Register No: ${student['regNo']}'),
                                Text('Mentor: ${student['mentor']}'),
                                Text('Phone: ${student['phone']}'),
                                Text('Days Present: ${student['daysPresent']}'),
                                Text('Days Absent: ${student['daysAbsent']}'),
                                Text('Status: ${student['isAbsent'] ? "Absent" : student['isOnDuty'] ? "On Duty" : "Present"}'),
                              ],
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  leading: Icon(
                    student['isPresent'] ? Icons.check_circle : Icons.remove_circle,
                    color: studentColor, // Green for present, Red for absent, Orange for on duty
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  
  getExternalStorageDirectory() {}
}
class DashboardCard extends StatelessWidget {
  final String title;
  final List<Widget> widgets;
  final VoidCallback? onMoreDetailsPressed;

  DashboardCard({
    required this.title,
    required this.widgets,
    this.onMoreDetailsPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                if (onMoreDetailsPressed != null)
                  TextButton(
                    onPressed: onMoreDetailsPressed,
                    child: Text('More Details'),
                  ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: widgets,
            ),
          ],
        ),
      ),
    );
  }
}

class StatWidget extends StatelessWidget {
  final String label;
  final int count;
  final Color countColor;
  final VoidCallback onStatClicked;

  StatWidget({
    required this.label,
    required this.count,
    required this.countColor,
    required this.onStatClicked,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onStatClicked,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '$count',
            style: TextStyle(
              fontSize: 18,
              color: countColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}