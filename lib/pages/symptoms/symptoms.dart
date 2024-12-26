import 'package:cherich_care_2/pages/symptoms/doc_guide.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cherich_care_2/pages/symptoms/view_symptoms.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Symptoms(),
    );
  }
}

class Symptoms extends StatelessWidget {
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
        backgroundColor:Colors.pinkAccent,
        title: const Text(
          'Symptoms',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(30),
          child: Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              'Check, Investigate & Next Steps',
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20), // Optional spacing after AppBar
              Image.asset(
                'assets/images/symptoms.png',
                width: 100,
                height: 100,
              ),
              SizedBox(height: 30),
              _customButton(context, 'View Symptoms', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewSymptoms()),
                );
              }),
              _dotSeparator(),
              _customButton(context, 'Doctor\nConversation Guide', () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DocGuide()),
                );
              }),
              _dotSeparator(),
              _customButton(context, 'Video', () {
                _launchUrl("https://www.youtube.com/@keerthikodithuwakku8114"); // Opens the Telegram link
              }, icon: Icons.videocam),
            ],
          ),
        ),
      ),
    );
  }

  Widget _customButton(BuildContext context, String text, VoidCallback onPressed, {IconData? icon}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
          ),
           padding: const EdgeInsets.symmetric(
            horizontal: 50, vertical: 15),
        minimumSize: Size(double.infinity, 50),
        //elevation: 2,
      ),
      
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, color: Colors.white) : Container(width: 0), // Icon spacing fix
      label: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _dotSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        '•••',
        style: TextStyle(color: Colors.pinkAccent,
        fontSize: 24),
      ),
    );
  }
}
