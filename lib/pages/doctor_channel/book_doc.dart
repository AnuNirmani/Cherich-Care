import 'package:cherich_care_2/pages/doctor_channel/session_card.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';



class BookDoc extends StatefulWidget {
  final String selectedDate;
  final String selectedHospital;

  const BookDoc({
    Key? key,
    required this.selectedDate, 
    required this.selectedHospital,
  }) : super(key: key);

  @override
  State<BookDoc> createState() => _BookDocState();
}

class _BookDocState extends State<BookDoc> {
  final DatabaseReference _database = FirebaseDatabase.instance
    .ref()
    .child('doctorSessions');
  Map<String, bool> sessionStatus = {};

  @override
  void initState() {
    super.initState();
    _listenToSessions();
  }

  void _listenToSessions() {
    _database.onValue.listen((event) {
      if (event.snapshot.value != null) {
        setState(() {
          final Map<dynamic, dynamic> data = event.snapshot.value as Map;
          sessionStatus = data.map((key, value) => 
            MapEntry(key.toString(), value['isBooked'] ?? false));
        });
      }
    });
  }

  Future<void> _bookSession(String sessionId) async {
    try {
      await _database.child(sessionId).set({
        'isBooked': true,
        'timestamp': ServerValue.timestamp,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Session booked successfully'))
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Booking failed: $e'))
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Doctor Details",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.pink.shade50,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.person_outline,
                      size: 80,
                      color: Colors.black,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Dr. Saman Bandara",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Special Notes: \nAvailable for channeling at Hemas Hospital - Wattala, Nawaloka Hospital Colombo, and Negombo. Please contact 0112222220 or 0115555220.",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14),
                    ),
                    const SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Hemas Hospital - Wattala Sessions"),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        side: const BorderSide(color: Colors.grey),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Oncologist - 12 Sessions"),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 07:00 AM",
                    sessionNumber: "No 1",
                    isBooked: sessionStatus['session1'] ?? false,
                    onBook: () => _bookSession('session1'),
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 07:15 AM",
                    sessionNumber: "No 2",
                    isBooked: sessionStatus['session2'] ?? false,
                    onBook: () => _bookSession('session2'),
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 07:30 AM",
                    sessionNumber: "No 3",
                    isBooked: sessionStatus['session3'] ?? false,
                    onBook: () => _bookSession('session3'),
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 07:45 AM",
                    sessionNumber: "No 4",
                    isBooked: sessionStatus['session4'] ?? false,
                    onBook: () => _bookSession('session4'),
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 08:00 AM",
                    sessionNumber: "No 5",
                    isBooked: sessionStatus['session5'] ?? false,
                    onBook: () => _bookSession('session5'),
                  ),
                  SessionCard(
                    date: "December 17, 2024",
                    time: "Tue 08:15 AM",
                    sessionNumber: "No 6",
                    isBooked: sessionStatus['session6'] ?? false,
                    onBook: () => _bookSession('session6'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}



class SessionCard extends StatelessWidget {
  final String date;
  final String time;
  final String sessionNumber;
  final bool isBooked;
  final VoidCallback onBook;

  const SessionCard({
    Key? key,
    required this.date,
    required this.time,
    required this.sessionNumber,
    required this.isBooked,
    required this.onBook,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(date, style: const TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(time),
                Text(sessionNumber),
              ],
            ),
            ElevatedButton(
              onPressed: isBooked ? null : onBook,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pinkAccent,
                disabledBackgroundColor: Colors.grey,
              ),
              child: Text(
                isBooked ? 'Booked' : 'Book',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}