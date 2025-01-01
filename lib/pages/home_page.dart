import 'package:flutter/material.dart';
import 'package:cherich_care_2/pages/calender/calender.dart';
import 'package:cherich_care_2/pages/insights/insights.dart';
import 'package:cherich_care_2/pages/profile/profile.dart';
import 'package:cherich_care_2/pages/self_exam.dart';
import 'package:cherich_care_2/pages/symptoms/symptoms.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'chart.dart';
import 'notes.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseService _firebaseService = FirebaseService();
  bool isPeriodTrackerEnabled = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadPeriodTrackerSetting();
  }

  Future<void> _loadPeriodTrackerSetting() async {
    try {
      final isEnabled = await _firebaseService.getPeriodTrackerSetting();
      setState(() {
        isPeriodTrackerEnabled = isEnabled;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading period tracker setting: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  Widget _buildMenuButton(BuildContext context, String label, String imagePath, Widget targetPage, {bool isEnabled = true}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 20),
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          backgroundColor: isEnabled ? Colors.pinkAccent : Colors.grey,
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 50.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        onPressed: isEnabled
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => targetPage),
                );
              }
            : null,
        icon: Image.asset(
          imagePath,
          width: 24,
          height: 24,
          color: Colors.white,
        ),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const Icon(Icons.arrow_forward, color: Colors.white),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink.shade50,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        title: const Text(
          'CHERISH CARE',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 30,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 25.0),
            child: Image.asset(
              'assets/images/logo.png',
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 50.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: const Center(
                        child: Text(
                          '14 Days Left For Next \n Self-Exam',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    _buildMenuButton(
                      context, 
                      'Calendar', 
                      'assets/images/calender.png', 
                      const Calendar(),
                      isEnabled: isPeriodTrackerEnabled
                    ),
                    _buildMenuButton(context, 'Chart', 'assets/images/chart.png', const Chart()),
                    _buildMenuButton(context, 'Notes', 'assets/images/note1.png', Notes()),
                  ],
                ),
              ),
            ),
      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildLinearNavItem(
              context,
              'assets/images/selfexam.png',
              'Self Exam',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => SelfExam())),
            ),
            _buildLinearNavItem(
              context,
              'assets/images/symptoms.png',
              'Symptoms',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => Symptoms())),
            ),
            _buildLinearNavItem(
              context,
              'assets/images/insights.png',
              'Insights',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => Insights())),
            ),
            _buildLinearNavItem(
              context,
              'assets/images/profile.png',
              'Profile',
              () => Navigator.push(context, MaterialPageRoute(builder: (context) => Profile())),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLinearNavItem(
      BuildContext context, String imagePath, String label, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            imagePath,
            width: 24,
            height: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black),
          ),
        ],
      ),
    );
  }
}