import 'package:flutter/material.dart';

class DocGuide extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Doctor Conversation Guide",
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
      body: Container(
        color: Colors.pink.shade50,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Title Section
                const Text(
                  "\nBefore You Go Reporting \nSymptoms",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.pinkAccent,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                // Character Image
                Image.asset(
                  'assets/images/doc.png', // Replace with your asset image path
                  height: 120,
                ),
                const SizedBox(height: 16),

                // Subtitle
                const Text(
                  "\n4 Things To Say To Your Doctor \nAbout Your Symptoms\n",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 16),

                // Step 1
                _buildStep(
                  image: const AssetImage('assets/images/doc_con_step1.png'),
                  title: "\n1. How long has it been there?",
                  description:
                      "Knowing when you first noticed it and whether it has gone away with your menstrual cycle helps to understand whether it's a common hormonal change or something else.\nNote: If you are reporting pain as a symptom this is a common complaint as breasts can easily become tender during the last half of the menstrual cycle. Breast pain related to the menstrual cycle comes and goes. However, if it's persisted for 4-6 weeks it's important to check it out.",
                  titleColor: Colors.pinkAccent,
                ),
                const SizedBox(height: 16),

                // Step 2
                _buildStep(
                  image: const AssetImage('assets/images/location.png'),
                  title: "\n2. Where is it located?",
                  description:
                      "Is it in the right or left breast? Near the nipple or the armpit? Typically if you notice the same thing in both breasts in the same area, it's usually nothing of concern. If it's a lump that sometimes is hard to find, draw an X on your skin with a marker so it can be located more easily during your appointment. You can also use the size of your fingers as a frame of reference, such as 3 finger width away from the nipple.",
                  titleColor: Colors.pinkAccent,
                ),
                const SizedBox(height: 16),

                // Step 3
                _buildStep(
                  image: const AssetImage('assets/images/symptoms.png'),
                  title: "\n3. What symptoms is it?",
                  description:
                      "Look at the 12 signs of breast cancer and read the description about the symptom you are concerned about. This can give you some medical terms to use which may help in describing it to your doctor.",
                  titleColor: Colors.pinkAccent,
                ),
                const SizedBox(height: 16),

                // Step 4
                _buildStep(
                  image: const AssetImage('assets/images/doc_con_step4.png'),
                  title: "\n4. Talk About Testing Options?",
                  description:
                      "According to the World Health Organization, if you have a concern that you feel is worth taking the time to talk to your doctor about, that is enough evidence to request testing whether or not your doctor can confirm your concern. While breast cancer typically happens at older ages, it does not mean that younger people cannot get breast cancer. Young people still need testing when a concern is raised.\n\nYour peace of mind is important too. If testing shows that the breast concern is fine, it is a mental health benefit. To know that your concern has been investigated and addressed in a timely way, is better than waiting and worrying. Don't put off your appointment when something doesn't seem right to you. Trust your instincts. No one knows your body better than you!",
                  titleColor: Colors.pinkAccent,
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
