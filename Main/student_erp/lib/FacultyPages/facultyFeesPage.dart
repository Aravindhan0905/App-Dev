import 'package:flutter/material.dart';

void main() {
  runApp(FacultyPage()); // Entry point of the application, runs FacultyPage widget
}

// Main page of the app, showing the Faculty dashboard
class FacultyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Faculty Dashboard'), // AppBar title
          leading: IconButton(
            icon: Icon(Icons.arrow_back), // Back button
            onPressed: () {
              Navigator.pop(context); // Functionality to go back when pressed
            },
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.person), // Profile icon
              onPressed: () {
                // Add profile functionality here
              },
            ),
          ],
        ),
        body: FacultyDashboard(), // Main body showing the dashboard
      ),
    );
  }
}

// Faculty Dashboard with student statistics
class FacultyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Padding for the dashboard
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch, // Align elements to stretch across
          children: [
            // Student Dashboard Card
            DashboardCard(
              title: 'Students Dashboard', // Title for students dashboard
              widgets: [
                StatWidget(
                  label: 'Avg Fees Paid', // Label for average fees paid
                  count: 350000, // Example average paid amount
                  countColor: Colors.green, // Green color for paid stats
                  onStatClicked: () {},
                ),
                StatWidget(
                  label: 'Fees Not Paid', // Label for fees not paid
                  count: 50000, // Example amount not paid
                  countColor: Colors.red, // Red color for not paid stats
                  onStatClicked: () {
                    // Example action for not paid fees
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AbsenteesPage(
                          absentees: [
                            {'name': 'John Doe', 'rollNo': '101'}, // Example student data
                            {'name': 'Jane Smith', 'rollNo': '102'},
                          ],
                        ),
                      ),
                    );
                  },
                ),
                StatWidget(
                  label: 'Yet to Pay', // Label for fees yet to pay
                  count: 20000, // Example amount yet to pay
                  countColor: Colors.orange, // Orange color for yet to pay stats
                  onStatClicked: () {},
                ),
              ],
              onMoreDetailsPressed: () {
                // Navigate to YearSelectionPage on pressing "More Details"
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

// Page showing the list of absent students
class AbsenteesPage extends StatelessWidget {
  final List<Map<String, String>> absentees; // List of absent students

  AbsenteesPage({required this.absentees}); // Constructor accepting the absentees list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Absent Students'), // AppBar title
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pop(context); // Go back on pressing the button
          },
        ),
      ),
      body: ListView.builder(
        itemCount: absentees.length, // Total number of absentees
        itemBuilder: (context, index) {
          final student = absentees[index]; // Get student at index
          return ListTile(
            title: Text(student['name']!), // Display student name
            subtitle: Text('Roll No: ${student['rollNo']}'), // Display roll number
          );
        },
      ),
    );
  }
}

// Page for selecting an academic year
class YearSelectionPage extends StatelessWidget {
  final List<String> years = ['1st Year', '2nd Year', '3rd Year', '4th Year']; // List of academic years

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Year'), // AppBar title
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pop(context); // Go back on pressing the button
          },
        ),
      ),
      body: ListView.builder(
        itemCount: years.length, // Total number of years
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Padding for each item
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(10), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow around items
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(years[index]), // Display the year
                onTap: () {
                  // Navigate to SectionSelectionPage for the selected year
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

// Page for selecting a section within a year
class SectionSelectionPage extends StatelessWidget {
  final String year; // The selected academic year
  final List<String> sections = ['Section A', 'Section B', 'Section C']; // List of sections

  SectionSelectionPage({required this.year}); // Constructor accepting the year

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Section for $year'), // AppBar title with selected year
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pop(context); // Go back on pressing the button
          },
        ),
      ),
      body: ListView.builder(
        itemCount: sections.length, // Total number of sections
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0), // Padding for each item
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // White background
                borderRadius: BorderRadius.circular(10), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5), // Shadow around items
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: ListTile(
                title: Text(sections[index]), // Display the section
                onTap: () {
                  // Navigate to SectionDashboard for the selected section
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SectionDashboard(
                        year: year, // Pass selected year
                        section: sections[index], // Pass selected section
                        students: List.generate(60, (index) {
                          // Generate student data with fee details
                          return {
                            'name': 'Student ${index + 1}', // Example student name
                            'rollNo': 'REG${index + 1}', // Example roll number
                            'tuitionFees': 20000 + (index * 500), // Example tuition fees
                            'busOrHostelFees': 5000 + (index * 200), // Example bus/hostel fees
                            'totalFees': 20000 + (index * 500) + 5000 + (index * 200), // Total fees
                            'totalPaid': 15000 + (index * 400), // Example total paid
                            'yetToPay': (20000 + (index * 500) + 5000 + (index * 200)) - (15000 + (index * 400)), // Yet to pay calculation
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

// Dashboard displaying attendance and details for a selected section
class SectionDashboard extends StatefulWidget {
  final String year; // Selected year
  final String section; // Selected section
  final List<Map<String, dynamic>> students; // List of students in the section

  SectionDashboard({required this.year, required this.section, required this.students});

  @override
  _SectionDashboardState createState() => _SectionDashboardState();
}

class _SectionDashboardState extends State<SectionDashboard> {
  // Function to handle the update of student's fees
  void _updateStudentFees(int index, double newTotalPaid) {
    setState(() {
      widget.students[index]['totalPaid'] = newTotalPaid;
      widget.students[index]['yetToPay'] = widget.students[index]['totalFees'] - newTotalPaid;
    });
  }

  // Function to show dialog for editing fees
  void _showEditDialog(int index) {
    final student = widget.students[index];
    TextEditingController totalPaidController = TextEditingController(text: student['totalPaid'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit Fees for ${student['name']}'),
          content: TextField(
            controller: totalPaidController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(labelText: 'Total Paid (₹)'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                double newTotalPaid = double.tryParse(totalPaidController.text) ?? student['totalPaid'];
                _updateStudentFees(index, newTotalPaid);
                Navigator.of(context).pop(); // Close the dialog after saving
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.section} - ${widget.year}'), // Display the section and year
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button
          onPressed: () {
            Navigator.pop(context); // Go back on pressing the button
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Padding for the dashboard
            child: Text(
              'Section Fees Overview', // Title for fees overview
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            // Excel-like table layout using DataTable widget
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Enable horizontal scrolling for wider tables
              child: DataTable(
                columns: [
                  DataColumn(label: Text('Roll No')), // Column for Roll Number
                  DataColumn(label: Text('Name')), // Column for Student Name
                  DataColumn(label: Text('Tuition Fees')), // Column for Tuition Fees
                  DataColumn(label: Text('Bus/Hostel Fees')), // Column for Bus/Hostel Fees
                  DataColumn(label: Text('Total Fees')), // Column for Total Fees
                  DataColumn(label: Text('Total Paid')), // Column for Total Paid
                  DataColumn(label: Text('Yet to Pay')), // Column for Yet to Pay
                  DataColumn(label: Text('Edit')), // Column for Edit button
                ],
                rows: widget.students.map((student) {
                  int index = widget.students.indexOf(student);
                  return DataRow(cells: [
                    DataCell(Text(student['rollNo'].toString())), // Roll number cell
                    DataCell(Text(student['name'].toString())), // Name cell
                    DataCell(Text('₹${student['tuitionFees'].toString()}')), // Tuition fees cell
                    DataCell(Text('₹${student['busOrHostelFees'].toString()}')), // Bus/Hostel fees cell
                    DataCell(Text('₹${student['totalFees'].toString()}')), // Total fees cell
                    DataCell(Text('₹${student['totalPaid'].toString()}', style: TextStyle(color: Colors.green))), // Total paid cell
                    DataCell(Text('₹${student['yetToPay'].toString()}', style: TextStyle(color: Colors.orange))), // Yet to pay cell
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.edit), // Edit icon
                        onPressed: () {
                          _showEditDialog(index); // Show dialog to edit fees
                        },
                      ),
                    ),
                  ]);
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Dashboard Card widget showing summary information
class DashboardCard extends StatelessWidget {
  final String title;
  final List<StatWidget> widgets;
  final VoidCallback onMoreDetailsPressed;

  DashboardCard({required this.title, required this.widgets, required this.onMoreDetailsPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: widgets,
            ),
            SizedBox(height: 16),
            TextButton(
              onPressed: onMoreDetailsPressed,
              child: Text('More Details'),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget showing a statistic with a label and count
class StatWidget extends StatelessWidget {
  final String label;
  final double count;
  final Color countColor;
  final VoidCallback onStatClicked;

  StatWidget({required this.label, required this.count, required this.countColor, required this.onStatClicked});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onStatClicked,
      child: Column(
        children: [
          Text(
            label,
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 8),
          Text(
            '₹${count.toStringAsFixed(0)}',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: countColor,
            ),
          ),
        ],
      ),
    );
  }
}