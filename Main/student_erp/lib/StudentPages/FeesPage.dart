import 'package:flutter/material.dart';
import 'HomePage.dart';
import 'AttendancePage.dart';
import 'NotesPage.dart';

class FeesPage extends StatefulWidget {
  const FeesPage({super.key});

  @override
  _FeesPageState createState() => _FeesPageState();
}

class _FeesPageState extends State<FeesPage> {
  final int _selectedIndex = 2;

  // Hardcoded student preferences (for demo)
  bool isHostelStudent = true;
  bool usesBus = false;

  // Mock data for fee details and payment history
  Map<String, dynamic> fees = {
    "Tuition Fees": {
      "Total": 50000,
      "Paid": 30000,
      "Due Date": "30 Sept 2024",
    },
    "Hostel Fees": {
      "Total": 20000,
      "Paid": 10000,
      "Due Date": "15 Sept 2024",
    },
    "Bus Fees": {
      "Total": 10000,
      "Paid": 5000,
      "Due Date": "1 Oct 2024",
    }
  };

  List<Map<String, dynamic>> paymentHistory = [
    {"Date": "1 Sept 2024", "Amount": 10000, "Status": "Paid"},
    {"Date": "15 Aug 2024", "Amount": 20000, "Status": "Paid"},
    {"Date": "10 July 2024", "Amount": 5000, "Status": "Paid"},
  ];

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AttendancePage()),
        );
        break;
      case 2:
        // Stay on FeesPage
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
        title: const Text('Fees'),
        leading: BackButton(
          color: Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Total Pending and Paid Fees
            Card(
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Total Pending Fees: ₹${fees["Tuition Fees"]["Total"] - fees["Tuition Fees"]["Paid"] + fees["Hostel Fees"]["Total"] - fees["Hostel Fees"]["Paid"] + fees["Bus Fees"]["Total"] - fees["Bus Fees"]["Paid"]}',
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Personalized Fees
            const Text('Your Fees',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            if (isHostelStudent) feeCard('Hostel Fees', fees['Hostel Fees']),
            if (usesBus) feeCard('Bus Fees', fees['Bus Fees']),
            feeCard('Tuition Fees', fees['Tuition Fees']),
            const SizedBox(height: 20),

            // Payment History
            const Text('Payment History',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: paymentHistory.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text("Date: ${paymentHistory[index]["Date"]}"),
                      subtitle:
                          Text("Amount: ₹${paymentHistory[index]["Amount"]}"),
                      trailing: Text(paymentHistory[index]["Status"]),
                    ),
                  );
                },
              ),
            ),

            // Online Payment Button
            ElevatedButton(
              onPressed: () {
                // Placeholder for online payment action
              },
              child: const Text('Pay Now'),
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

  // Widget for fee cards
  Widget feeCard(String feeType, Map<String, dynamic> feeDetails) {
    return Card(
      elevation: 5,
      child: ListTile(
        title: Text(feeType),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total: ₹${feeDetails["Total"]}'),
            Text('Paid: ₹${feeDetails["Paid"]}'),
            Text('Due Date: ${feeDetails["Due Date"]}'),
          ],
        ),
      ),
    );
  }
}
