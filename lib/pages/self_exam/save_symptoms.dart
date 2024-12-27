import 'package:cherich_care_2/pages/doctor_channel/channel_doctor.dart';
import 'package:cherich_care_2/pages/self_exam/self_exam.dart';
import 'package:flutter/material.dart';

class SaveSymptoms extends StatelessWidget {
  const SaveSymptoms({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Warning Message Container
              Container(
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 184, 0, 0),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.warning,
                      color: Color.fromARGB(255, 255, 230, 0),
                      size: 50,
                    ),
                    SizedBox(height: 8),
                    Text(
                      "You are Identified as in a",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "High Risk !",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Help Text
              const Text(
                "\nDon’t be Afraid.\nWe are all here to help you.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 19,
                ),
              ),
              const SizedBox(height: 50),
              // Channel a Doctor Button
              ElevatedButton(
                onPressed: () {
                  // Add your logic to navigate or call a doctor
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChannelDoctor(), // Replace with the desired screen
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "Channel a doctor",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Channel a Doctor Button
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SelfExam(), // Replace with the desired screen
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 253, 0, 0),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 14,
                  ),
                ),
                child: const Text(
                  "May be Later",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
