import 'package:cherich_care_2/pages/doctor_channel/channel_doctor.dart';
import 'package:cherich_care_2/pages/profile/profile.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:flutter/material.dart';
// import 'package:cherich_care_2/services/firebase_service.dart';

class ScreenPlanP extends StatefulWidget {
  const ScreenPlanP({super.key});

  @override
  State<ScreenPlanP> createState() => _ScreenPlanPState();
}

class _ScreenPlanPState extends State<ScreenPlanP> {
  // Controllers for the text fields
  final TextEditingController _doctorVisitController = TextEditingController();
  final TextEditingController _mamogramController = TextEditingController();
  final TextEditingController _breastMRIController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadExistingPlan();
  }

  Future<void> _loadExistingPlan() async {
    try {
      final plan = await _firebaseService.getScreeningPlan();
      if (plan != null && mounted) {
        setState(() {
          _doctorVisitController.text = plan['doctorVisit'] ?? 'not set';
          _mamogramController.text = plan['mammogram'] ?? 'not set';
          _breastMRIController.text = plan['breastMRI'] ?? 'not set';
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error loading plan: $e')),
        );
      }
    }
  }

  Future<void> _handleSave() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await _firebaseService.saveScreeningPlan(
        doctorVisit: _doctorVisitController.text,
        mammogram: _mamogramController.text,
        breastMRI: _breastMRIController.text,
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Screening plan saved successfully!')),
        );
        
        print('Doctor Visit: ${_doctorVisitController.text}');
        print('Mammogram: ${_mamogramController.text}');
        print('Breast MRI: ${_breastMRIController.text}');

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Profile()),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error saving plan: $e')),
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

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
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '\nDoctor Visit',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(_doctorVisitController),
            const SizedBox(height: 20),

            const Text(
              'Mammogram',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(_mamogramController),
            const SizedBox(height: 20),

            const Text(
              'Breast MRI',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
            const SizedBox(height: 8),
            _buildTextField(_breastMRIController),
            const SizedBox(height: 36),

            Center(
              child: SizedBox(
                width: 130,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                ),
              ),
            ),
            const SizedBox(height: 16),

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
                    backgroundColor: Colors.blue,
                    minimumSize: const Size(150, 50),
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

  Widget _buildTextField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'not set',
        hintStyle: TextStyle(color: Colors.grey[400]),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        suffixIcon: IconButton(
          icon: Image.asset(
            'assets/images/note2.png',
            width: 24,
            height: 24,
          ),
          onPressed: () {
            // Handle the icon press
          },
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.white,
      ),
    );
  }
}