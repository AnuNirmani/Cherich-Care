import 'package:cherich_care_2/pages/profile/profile.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:flutter/material.dart';

// New Page to Navigate to after Save
// class NewPage extends StatelessWidget {
//   const NewPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.pinkAccent,
//         title: const Text('New Page'),
//         centerTitle: true,
//       ),
//       body: const Center(
//         child: Text(
//           'You have successfully selected a profile picture!',
//           style: TextStyle(fontSize: 20),
//         ),
//       ),
//     );
//   }
// }



class ProfilePic extends StatefulWidget {
  const ProfilePic({super.key});

  @override
  State<ProfilePic> createState() => _ProfilePicState();
}

class _ProfilePicState extends State<ProfilePic> {
  int _selectedProfileIndex = -1; // Keeps track of the selected profile picture
  final FirebaseService _firebaseService = FirebaseService();
  bool _isLoading = false;

  // List of images for the profile pictures
  final List<String> _profilePics = [
    'assets/images/profile1.png',
    'assets/images/profile2.png',
    'assets/images/profile3.png',
    'assets/images/profile4.png',
    'assets/images/profile5.png',
    'assets/images/profile6.png',
  ];

    Future<void> _saveProfilePicture() async {
    if (_selectedProfileIndex == -1) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a profile picture'),
        ),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Save the selected profile picture path to Firebase
      await _firebaseService.saveProfilePicture(_profilePics[_selectedProfileIndex]);

      if (mounted) {
        // Navigate back to Profile with the selected picture
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Profile(
              selectedProfilePic: _profilePics[_selectedProfileIndex],
            ),
          ),
        );
      }
    } catch (e) {
      print('Error saving profile picture: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving profile picture: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Choose Your Profile Picture',
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
      backgroundColor: Colors.pink[50], // Light pink background
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Two items per row
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                itemCount: _profilePics.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedProfileIndex = index; // Update selected picture index
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: _selectedProfileIndex == index
                              ? Colors.pinkAccent // Highlight the selected image
                              : Colors.transparent,
                          width: 4.0,
                        ),
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          _profilePics[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isLoading ? null : _saveProfilePicture,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pinkAccent,
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: _isLoading
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
              ),
            ),
                      ],
        ),
      ),
    );
  }
}
