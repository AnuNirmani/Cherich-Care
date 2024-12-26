import 'package:cherich_care_2/pages/profile/change_name_email.dart';
import 'package:cherich_care_2/pages/profile/profile_pic.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// Import your new pages
import 'settings/settings.dart';
import 'reminders.dart';
import 'screen_plan_p.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
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
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile Picture with GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProfilePic(), // Navigate to NewProfilePage
                  ),
                );
              },
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                child: ClipOval(
                  child: Image.asset(
                    'assets/images/profile1.png', // Replace with actual profile image asset
                    fit: BoxFit.cover,
                    width: 120,
                    height: 120,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Name Field with GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangeNameEmail()),
                );
              },
              child: TextField(
                enabled: false, // Disable direct editing
                decoration: InputDecoration(
                  hintText: 'Oshini',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 3),

            // Email Field with GestureDetector
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChangeNameEmail()),
                );
              },
              child: TextField(
                enabled: false, // Disable direct editing
                decoration: InputDecoration(
                  hintText: 'oshilak@gmail.com',
                  hintStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Settings List
            _buildListItem(
              context,
              icon: Icons.settings,
              title: "Settings",
              page: Settings(),
            ),
            _buildListItem(
              context,
              icon: Icons.map,
              title: "Screening Plan",
              page: const ScreenPlanP(),
            ),
            _buildListItem(
              context,
              icon: Icons.notifications,
              title: "Reminders",
              page: Reminders(),
            ),
            _buildSendFeedbackItem(
              context,
              icon: Icons.feedback,
              title: "Send Feedback",
              url: "https://play.google.com/store/games?hl=en&pli=1",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListItem(BuildContext context,
      {required IconData icon, required String title, required Widget page}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 255, 46, 115),
          size: 28,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color.fromARGB(255, 255, 46, 115),
          size: 20,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }

  Widget _buildSendFeedbackItem(BuildContext context,
      {required IconData icon, required String title, required String url}) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(
          icon,
          color: const Color.fromARGB(255, 255, 46, 115),
          size: 28,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color.fromARGB(255, 255, 46, 115),
          size: 20,
        ),
        onTap: () async {
          if (await canLaunch(url)) {
            await launch(url);
          } else {
            throw 'Could not launch $url';
          }
        },
      ),
    );
  }
}
