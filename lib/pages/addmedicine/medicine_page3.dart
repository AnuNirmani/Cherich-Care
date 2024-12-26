import 'package:cherich_care_2/pages/home_page.dart';
import 'package:flutter/material.dart';

class MedicinePage3 extends StatefulWidget {
  @override
  _MedicinePage3State createState() => _MedicinePage3State();
}

class _MedicinePage3State extends State<MedicinePage3> {
  bool isVibrate = true;
  bool isRingtoneEnabled = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        backgroundColor: Colors.pink[100],
        elevation: 0,
        title: Text(
          "Vienva Reminder",
          style: TextStyle(color: Colors.pink[700]),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.pink[700]),
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
            SizedBox(height: 30),
             // Notification Text
            Text(
              "Notification Text",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "Tap to edit",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            // Snooze
            Text(
              "Snooze",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(
                hintText: "0 minute, 0 time",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            // Vibrate
            Row(
              children: [
                Text(
                  "Vibrate",
                  style: TextStyle(fontSize: 18),
                ),
                Spacer(),
                Checkbox(
                  value: isVibrate,
                  activeColor: Colors.pink,
                  onChanged: (bool? value) {
                    setState(() {
                      isVibrate = value ?? false;
                    });
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Divider(thickness: 1, color: Colors.black26),
            SizedBox(height: 20),
            // Ringtone
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ringtone",
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Default (Spaceline)",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                ),
                Checkbox(
                  value: isRingtoneEnabled,
                  activeColor: Colors.pink,
                  onChanged: (bool? value) {
                    setState(() {
                      isRingtoneEnabled = value ?? false;
                    });
                  },
                ),
              ],
            ),
            Spacer(),
            // Next Button
            Center(
                child: SizedBox(
                  width: 130,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()), // Redirects to SignIn again
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Save",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MedicinePage3(),
  ));
}
