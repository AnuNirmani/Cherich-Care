import 'package:cherich_care_2/services/firebase.dart';
import 'package:flutter/material.dart';



class Report extends StatefulWidget {
  const Report({Key? key}) : super(key: key);

  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  Map<String, dynamic>? _symptomsData;
  Map<String, String?>? _symptomValues;

  final FirebaseService _firebaseService = FirebaseService();

  Future<void> _fetchSymptoms() async {
    final symptoms = await _firebaseService.fetchSymptoms();
    setState(() {
      _symptomsData = symptoms;
      _parseSymptomValues();
    });
  }

  void _parseSymptomValues() {
    if (_symptomsData != null) {
      Map<String, dynamic> data =
          Map<String, dynamic>.from(_symptomsData!['data']);
      _symptomValues = {};
      data.forEach((key, value) {
        _symptomValues![key] = value;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchSymptoms();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Cherry Analysis Report",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.pink.shade50, // Light pink background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Date
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Date :- 16/12/2024",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Symptoms Section
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Identified symptoms by you, when doing the self exam",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  if (_symptomValues != null)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _symptomValues!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(_symptomValues!.keys.elementAt(index),
                                  style: TextStyle(fontSize: 14)),
                              Text(
                                  _symptomValues![_symptomValues!.keys
                                          .elementAt(index)] ??
                                      'Not specified',
                                  style: TextStyle(fontSize: 14))
                            ],
                          ),
                        );
                      },
                    )
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Risk Level
            /*const Text(
              "Risk Level :",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "You are identified as in a low risk.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 20),*/
            // Recommendation
            const Text(
              "We are recommending always talk to your doctor when making health decisions.",
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}