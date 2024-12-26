import 'package:cherich_care_2/pages/doctor_channel/channel_doctor.dart';
import 'package:cherich_care_2/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class ScreenPlanP extends StatefulWidget {
  const ScreenPlanP({super.key});

  @override
  State<ScreenPlanP> createState() => _ScreenPlanPState();
}

class _ScreenPlanPState extends State<ScreenPlanP> {
  // Controllers for the text fields
  final TextEditingController _doctorVisitController = TextEditingController(text: 'not set');
  final TextEditingController _mamogramController = TextEditingController(text: 'not set');
  final TextEditingController _breastMRIController = TextEditingController(text: 'not set');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Screening Plan',
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
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.pink[50], // Light pink background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Doctor Visit field
            const Text(
              '\nDoctor Visit',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(_doctorVisitController),
            const SizedBox(height: 20),

            // Mammogram field
            const Text(
              'Mammogram',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(_mamogramController),
            const SizedBox(height: 20),

            // Breast MRI field
            const Text(
              'Breast MRI',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(_breastMRIController),
            const SizedBox(height: 36),

           
            // Save button centered in the middle
            Center(
              child: SizedBox(
                width: 130,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Profile()),
                    );
                    print('Doctor Visit: ${_doctorVisitController.text}');
                    print('Mammogram: ${_mamogramController.text}');
                    print('Breast MRI: ${_breastMRIController.text}');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent, // Pink color for the button
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: const Text(
                    'Save',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Channel a Doctor button
            Center(
              child: SizedBox(
                width: 220,
                height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChannelDoctor()),
                  );
                  print('Channel a doctor');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Blue color for the button
                  minimumSize: const Size(150, 50), // Adjusted size
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Channel a Doctor',
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
              ),
            ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create text fields
  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        suffixIcon: IconButton(
          icon: Image.asset(
            'assets/images/note2.png', // Replace with the actual path of your image
            width: 24,
            height: 24,
          ),
          onPressed: () {
            // Handle the icon press, for example show date picker or anything else
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}
