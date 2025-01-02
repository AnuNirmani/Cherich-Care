import 'package:cherich_care_2/pages/doctor_channel/channel_page.dart';
import 'package:flutter/material.dart';



class SessionCard extends StatelessWidget {
  final String date;
  final String time;
  final String sessionNumber;
  final bool isBooked;

  const SessionCard({super.key, 
    required this.date,
    required this.time,
    required this.sessionNumber,
    required this.isBooked,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      //color: isBooked ? Colors.redAccent.shade100 : Colors.white,
      child: ListTile(
        title: Text(
          "$date - $time",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isBooked ? Colors.black54 : Colors.black,
          ),
        ),
        subtitle: Text("Session: $sessionNumber"),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isBooked ? Colors.grey : Colors.pinkAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: isBooked
              ? null
              : () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const ChannelPage(doctorName: "Dr. Saman Bandara"),
                    ),
                  );
                },
          child: Text(
            isBooked ? "Booked" : "Book",
            style: const TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ),
    );
  }
}