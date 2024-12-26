import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:cherich_care_2/pages/symptoms/sym1.dart';

// Import other symptom pages here...

class ViewSymptoms extends StatelessWidget {
  final List<String> symptoms = [
    "Hard Lump",
    "Thick Area",
    "Dimple",
    "Nipple Crust",
    "Red or Hot",
    "New Fluid",
    "Skin Sores",
    "Bump",
    "Growing Vein",
    "Sunken Nipple",
    "New Shape or New Size",
    "“Orange Peel” Skin",
  ];

  final Map<String, Widget> symptomPages = {
    "Hard Lump": Sym1(),
    "Thick Area": Sym2(),
    "Dimple": Sym3(), 
    "Nipple Crust": Sym4(), 
    "Red or Hot": Sym5(), 
    "New Fluid": Sym6(), 
    "Skin Sores": Sym7(), 
    "Bump": Sym8(), 
    "Growing Vein": Sym9(), 
    "Sunken Nipple": Sym10(), 
    "New Shape or New Size": Sym11(), 
    "“Orange Peel” Skin": Sym12(), 
  };

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
          "12 Symptoms",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
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
      body: Column(
        children: [
          // Info Section
          Container(
            color: Colors.pink[50],
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const Text(
                  "Seeing something like this?\nDon't panic. Many changes are normal, but it's always smart to check them out carefully.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      icon: Image.asset(
                        'assets/images/fb.png',
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () => _launchUrl("https://www.facebook.com/facebook/"),
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/images/instagram.png',
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () => _launchUrl("https://www.instagram.com/"),
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/images/video.png',
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () => _launchUrl("https://www.youtube.com/@keerthikodithuwakku8114"),
                    ),
                    IconButton(
                      icon: Image.asset(
                        'assets/images/whatsapp.png',
                        width: 28,
                        height: 28,
                      ),
                      onPressed: () => _launchUrl("https://web.whatsapp.com/"),
                    ),
                  ],
                ),
                const Text(
                  "Share + Follow",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent,
                  ),
                ),
              ],
            ),
          ),

          // Symptom List
          Expanded(
            child: ListView.builder(
              itemCount: symptoms.length,
              itemBuilder: (context, index) {
                final symptom = symptoms[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        symptom,
                        style: const TextStyle(fontSize: 16, color: Colors.black),
                      ),
                      trailing: const Icon(Icons.arrow_forward, color: Colors.pinkAccent),
                      onTap: () {
                        // Navigate to the corresponding page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => symptomPages[symptom] ?? Sym1(),
                          ),
                        );
                      },
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.pink[200],
                      indent: 16,
                      endIndent: 16,
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
