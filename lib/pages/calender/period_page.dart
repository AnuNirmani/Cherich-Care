import 'package:cherich_care_2/pages/calender/add_note.dart';
import 'package:cherich_care_2/pages/calender/edit_period.dart';
import 'package:cherich_care_2/pages/calender/notes_page.dart';
import 'package:cherich_care_2/pages/calender/quiz.dart';
import 'package:flutter/material.dart';

class PeriodPage extends StatelessWidget {
  const PeriodPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 10.0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        "• Period Ends",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddNote(initialDate: '',)),
                          );
                        },
                        child: const Text(
                          "• Add Note",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Quiz()),
                          );
                        },
                        child: const Text(
                          "• Help",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      const Text(
                        "• Remove Period",
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditPeriod()),
                          );
                        },
                        child: const Text(
                          "• Edit Period",
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ),
                      const SizedBox(height: 24.0),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "OK",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
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