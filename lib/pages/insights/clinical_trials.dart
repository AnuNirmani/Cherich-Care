import 'package:flutter/material.dart';

class ClinicalTrials extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Clinical Trials",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Main content text
              Text(
                "\nThe medicines you use, like Tylenol and Tums were made available to you because of clinical trials. Clinical trials help us know what works in people and if the side effects are acceptable compared to the benefits. People who participate in a clinical trial get access to new treatments before they are widely available. For breast cancer, before a new medicine is tested in a clinical trial, it undergoes at least six years of study first. There are also clinical trials that you can participate in when you are healthy.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              // Wisdom Study Section
              Text(
                "Wisdom Study:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "This is to learn what screening options are best for people based on different risk factors. This is for people who have not been diagnosed with breast cancer but want to contribute to helping figure out screening recommendations.\n",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              // When We Trial Section
              Text(
                "When We Trial:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "For breast cancer patients, with an emphasis on recruiting women from minority groups to ensure a range of bodies are included when understanding how to best treat them for cancer.",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              // Bottom padding for safe scrolling
              SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
