import 'package:cherich_care_2/pages/calender/calender.dart';
import 'package:cherich_care_2/pages/home_page.dart';
import 'package:cherich_care_2/pages/self_exam/check_area.dart';
import 'package:cherich_care_2/pages/self_exam/feel_with.dart';
import 'package:cherich_care_2/pages/self_exam/pay_attention.dart';
import 'package:cherich_care_2/pages/self_count.dart';
import 'package:cherich_care_2/pages/symptoms/view_symptoms.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class SelfExam extends StatelessWidget {

  Future<void> _launchUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Self-Exam',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false,
      );
    },
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Guide & Report',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.pink.shade50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                Image.asset(
                  'assets/images/selfexam.png',
                  width: 100,
                  height: 100,
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Proper and regular breast self-examination is crucial for the detection of early changes in breasts, which could indicate even cancer. Breasts should be carefully examined 7 to 10 days after the start of your period, or if you don’t have it, at a select day of the month.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CheckArea()), // Navigate to FeelWithPage
                    );
                  },
                  child: const Text(
                    'Which area to check ?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FeelWith()), // Navigate to FeelWithPage
                    );
                  },
                  child: const Text(
                    'Feel with ?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PayAttention()), // Navigate to FeelWithPage
                    );
                  },
                  child: const Text(
                    'What to pay attention ?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.pinkAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Divider(
                  color: Colors.grey.shade400,
                  thickness: 1,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Tools :',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    Row(
                      children: [
                        _buildImageButton(
                        imagePath: 'assets/images/video.png',
                        label: "",
                        onPressed: () {
                        _launchUrl("https://www.youtube.com/@keerthikodithuwakku8114");
                        },
                      ),
                        const SizedBox(width: 10), // Small space between video and sound
                        
                        _buildImageButton(
                        imagePath: 'assets/images/q.png',
                        label: "",
                        onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewSymptoms()),
                        );
                      },
                    ),
                        _buildImageButton(
                        imagePath: 'assets/images/hand.png',
                        label: "",
                        onPressed: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Calendar()),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

                const SizedBox(height: 10),
                GestureDetector(
  onTap: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelfCount()), // Navigate to SelfCountPage
    );
  },
  child: Container(
    margin: const EdgeInsets.all(16),
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: const Center(
      child: Text(
        'Tap to make your self count',
        style: TextStyle(
          fontSize: 18,
          color: Colors.pinkAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  ),
),

              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageButton({
    required String imagePath,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Column(
      children: [
        GestureDetector(
          onTap: onPressed,
          child: Image.asset(
            imagePath,
            width: 35,
            height: 35,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}
