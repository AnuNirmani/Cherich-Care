import 'package:cherich_care_2/pages/all_bad.dart';
import 'package:cherich_care_2/pages/save_symptoms2.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:cherich_care_2/pages/save_symptoms.dart';
import 'package:flutter/material.dart';

class ReviewSymptoms extends StatefulWidget {
  const ReviewSymptoms({Key? key}) : super(key: key);

  @override
  State<ReviewSymptoms> createState() => _ReviewSymptomsState();
}

class _ReviewSymptomsState extends State<ReviewSymptoms> {
  final Map<String, String> selectedSide = {};

  Future<void> _saveSymptomsToDB() async {
    try {
      // Create a map to store symptoms with their selected sides
      Map<String, dynamic> symptomsData = {
        'symptoms': selectedSide,
      };

      FirebaseService firebaseService = FirebaseService();
      await firebaseService.saveSymptoms(symptomsData);

      // Count Left and Right selections
      int leftCount =
          selectedSide.values.where((side) => side == 'Left').length;
      int rightCount =
          selectedSide.values.where((side) => side == 'Right').length;

      // Show success snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Analysis saved successfully !'),
          backgroundColor: Colors.green,
        ),
      );

      // Navigate based on Left and Right count
      if (leftCount > 4 || rightCount > 4) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SaveSymptoms(),
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SaveSymptoms2(),
          ),
        );
      }
    } catch (error) {
      // Show error snackbar if saving fails

      print(error);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save analysis: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Cherry Analysis',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => AllBad()),
        (route) => false,
      );
    },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  _buildSymptomRow('Hard lump'),
                  _buildSymptomRow('Thick area'),
                  _buildSymptomRow('Dimple'),
                  _buildSymptomRow('Nipple crust'),
                  _buildSymptomRow('Red or hot'),
                  _buildSymptomRow('New fluid'),
                  _buildSymptomRow('Skin sores'),
                  _buildSymptomRow('Bump'),
                  _buildSymptomRow('Growing vein'),
                  _buildSymptomRow('Sunken nipple'),
                  _buildSymptomRow('New shape or new size'),
                  _buildSymptomRow('"Orange peel" skin'),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                onPressed: () {
                  // Check if all symptoms have been selected (including None)
                  if (selectedSide.length == 12) {
                    _saveSymptomsToDB();
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            'Please select a side or None for all symptoms'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                },
                child: const Text(
                  'Save',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  Widget _buildSymptomRow(String symptom) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              symptom,
              style: const TextStyle(fontSize: 16, color: Colors.black),
            ),
          ),
          const SizedBox(width: 20),
          Row(
            children: [
              Radio<String>(
                value: 'None',
                groupValue: selectedSide[symptom],
                onChanged: (value) {
                  setState(() {
                    selectedSide[symptom] = value!;
                  });
                },
              ),
              const Text('None'),
            ],
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              Radio<String>(
                value: 'Left',
                groupValue: selectedSide[symptom],
                onChanged: (value) {
                  setState(() {
                    selectedSide[symptom] = value!;
                  });
                },
              ),
              const Text('Left'),
            ],
          ),
          const SizedBox(width: 10),
          Row(
            children: [
              Radio<String>(
                value: 'Right',
                groupValue: selectedSide[symptom],
                onChanged: (value) {
                  setState(() {
                    selectedSide[symptom] = value!;
                  });
                },
              ),
              const Text('Right'),
            ],
          ),
        ],
      ),
    );
  }
}
