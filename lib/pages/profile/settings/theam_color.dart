import 'package:cherich_care_2/pages/profile/settings/settings.dart';
import 'package:flutter/material.dart';

class ThemeColor extends StatefulWidget {
  @override
  _ThemeColorState createState() => _ThemeColorState();
}

class _ThemeColorState extends State<ThemeColor> {
  int? selectedColorIndex; // Track the selected color box

  // Custom color themes
  final List<List<Color>> colorThemes = [
    [Colors.pinkAccent, const Color.fromARGB(255, 252, 228, 236), const Color.fromARGB(255, 255, 228, 228)],
    [Colors.black, const Color.fromARGB(255, 214, 214, 214), const Color.fromARGB(255, 80, 80, 80)],
    [Colors.blue, Colors.indigo, Colors.cyan],
    [Colors.purple, Colors.deepPurple, Colors.pink],
    [Colors.grey, Colors.black54, Colors.black],
    [Colors.blue[300]!, Colors.blue[500]!, Colors.blue[700]!],
    [Colors.pink[200]!, Colors.pink[400]!, Colors.pink[600]!],
    [Colors.purple[200]!, Colors.purple[400]!, Colors.purple[600]!],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10.0,
                offset: Offset(0, 5),
              ),
            ],
          ),
          width: MediaQuery.of(context).size.width * 0.85,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Select The Theme",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 15),
              GridView.builder(
                shrinkWrap: true,
                itemCount: colorThemes.length, // Number of custom themes
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3, // Width to height ratio
                ),
                itemBuilder: (context, index) {
                  bool isSelected = index == selectedColorIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedColorIndex = index; // Update selected color index
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.pink[100] : Colors.transparent,
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: isSelected ? Colors.pink : Colors.black12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: colorThemes[index]
                            .map((color) => Container(
                                  width: 20,
                                  height: 20,
                                  margin: const EdgeInsets.symmetric(horizontal: 2),
                                  color: color,
                                ))
                            .toList(),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: selectedColorIndex == null
                    ? null // Disable button if no color is selected
                    : () {
                        // Save the selected color and navigate to the Settings screen
                        final selectedColors = colorThemes[selectedColorIndex!];

                        print("Selected Colors: $selectedColors");

                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const Settings()),
                          (route) => false,
                        );
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 40,
                  ),
                ),
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
