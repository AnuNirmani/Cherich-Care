import 'package:cherich_care_2/main.dart';
import 'package:cherich_care_2/services/auth.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'sign_up.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();

  // State variables for form fields
  String? _selectedCountry;
  String? _birthSex;
  String? _breastsRemoved;
  String? _menopause;
  String? _menstruate;

  // Function to save user data to Firebase
  Future<void> _saveUserData() async {
    if (_formKey.currentState!.validate()) {
      try {
        final FirebaseService firebaseService = FirebaseService();

        Map<String, dynamic> userData = {
          'firstName': _firstNameController.text,
          'country': _selectedCountry,
          'birthSex': _birthSex,
          'breastsRemoved': _breastsRemoved,
          'menopause': _menopause,
          'menstruate': _menstruate,
          'timestamp': ServerValue.timestamp,
        };

        await firebaseService.saveUserData(userData);

//        await firebaseService.saveUserData(userData, Auth().currentUser?.uid ?? "");

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyApp()),
        );
      } catch (e) {
        print(e);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error saving data: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "\nTo customize Cherish Care according to your body, we need to ask a few questions from you",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _firstNameController,
                    decoration: InputDecoration(
                      labelText: "First Name*",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your first name";
                      }
                      if (value.length < 2) {
                        return "First name must be at least 2 characters long";
                      }
                      if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                        return "First name can only contain alphabets and spaces";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      labelText: "Country you live",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    value: _selectedCountry,
                    items: ["Sri Lanka", "UK", "Japan", "China", "Korea", "Germany", "Spain"]
                        .map((country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCountry = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please select your country";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  _buildRadioGroup(
                    "What sex were you assigned at birth?",
                    ["Boy", "Girl"],
                    _birthSex,
                    (value) => setState(() => _birthSex = value),
                  ),
                  const SizedBox(height: 20),
                  _buildRadioGroup(
                    "Have you had both breasts removed?",
                    ["Yes", "No"],
                    _breastsRemoved,
                    (value) => setState(() => _breastsRemoved = value),
                  ),
                  const SizedBox(height: 20),
                  _buildRadioGroup(
                    "Have you entered menopause yet?",
                    ["Yes", "No"],
                    _menopause,
                    (value) => setState(() => _menopause = value),
                  ),
                  const SizedBox(height: 20),
                  _buildRadioGroup(
                    "Do you menstruate?",
                    ["Yes", "No"],
                    _menstruate,
                    (value) => setState(() => _menstruate = value),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignUp(),
                          ),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Back to ",
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign Up",
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Center(
                    child: SizedBox(
                      width: 130,
                      height: 40,
                      child: ElevatedButton(
                        onPressed: _saveUserData,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Let's Start",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildRadioGroup(
    String title,
    List<String> options,
    String? groupValue,
    void Function(String?) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Row(
          children: options
              .map(
                (option) => Expanded(
                  child: Row(
                    children: [
                      Radio<String>(
                        value: option,
                        groupValue: groupValue,
                        onChanged: onChanged,
                      ),
                      Text(option),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ],
    );
  }
}
