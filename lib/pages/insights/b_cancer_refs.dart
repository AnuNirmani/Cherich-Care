import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BCancerRefs extends StatelessWidget {
  //final String url = "https://web.telegram.org/a/#1512449726";

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
          "Breast Cancer References",
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
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "\nWe are providing carefully selected references to promote awareness and education on breast cancer. The information is intended to help individuals understand the importance of early detection and prevention.\n\nThese references are for educational purposes only, and we encourage you to perform regular self-exams and consult with your healthcare provider before making any health-related decisions.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildImageButton(
                      imagePath: 'assets/images/video.png', // Path to your Videos image
                      label: "Videos",
                      onPressed: () {
                        _launchUrl("https://www.youtube.com/@keerthikodithuwakku8114");
                      },
                    ),
                    _buildImageButton(
                      imagePath: 'assets/images/book.png', // Path to your Books image
                      label: "Books",
                      onPressed: () {
                        _launchUrl("https://www.goodreads.com/shelf/show/breast-cancer");
                      },
                    ),
                    _buildImageButton(
                      imagePath: 'assets/images/web.png', // Path to your Web Links image
                      label: "Web Links",
                      onPressed: () {
                        _launchUrl("https://www.who.int/news-room/fact-sheets/detail/breast-cancer");
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
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
            width: 80,  // Adjust the size as needed
            height: 80,
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
