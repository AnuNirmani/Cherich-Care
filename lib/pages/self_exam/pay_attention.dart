import 'package:flutter/material.dart';

class PayAttention extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Self-Exam",
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
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Title Section
                const Text(
                  "\nWhat to pay attention ?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Character Image
                Image.asset(
                  'assets/images/selfexam2.png', // Replace with your asset image path
                  height: 120,
                ),
                const SizedBox(height: 16),

                // Subtitle
                const Text(
                  "• Any changes in color, shape and size of thr breast, dimpling, puckering or bulging. \n• Any palpable changes. \n• Any nipple changes, inverted nipples, any fluid coming out.",
                  //textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16), 
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper widget to build each step
  Widget _buildStep({
    ImageProvider? image,
    IconData? icon, // Add IconData parameter
    Color? iconColor, // Add icon color parameter
    required String title,
    required String description,
    Color titleColor = Colors.black, // Default color for the title
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon or Image
          Center(
            child: icon != null
                ? Icon(
                    icon,
                    size: 80,
                    color: iconColor ?? Colors.pinkAccent, // Apply custom color
                  )
                : Image(
                    image: image!,
                    height: 80,
                  ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            title,
            style: TextStyle(
              color: titleColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),

          // Description
          Text(
            description,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
