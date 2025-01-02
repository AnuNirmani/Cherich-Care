import 'package:cherich_care_2/main.dart';
import 'package:cherich_care_2/pages/auth/sign_in.dart';
import 'package:cherich_care_2/pages/profile/change_name_email.dart';
import 'package:cherich_care_2/services/auth.dart';
import 'package:cherich_care_2/services/firebase.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart'; // Import url_launcher

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _emailController = TextEditingController();
  final _usernameController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();
  

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> _login() async {
  try {
    // First create the user authentication
    Map<String, dynamic> result = await Auth().createUserWithEmailandPassword(
      _emailController.text,
      _passwordController.text,
    );
    
    // Save the initial user profile data
    final FirebaseService firebaseService = FirebaseService();
    Map<String, dynamic> userData = {
      'username': _usernameController.text,
      'email': _emailController.text,
      'createdAt': ServerValue.timestamp,
    };
    
    await firebaseService.saveUserData(userData);

    // Navigate to SignIn page after successful signup
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) =>  SignIn(),  // Replace ChangeNameEmail with SignIn
        ),
      );
    }
  } on Exception catch (e) {
    print('Error during signup: $e');
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error during signup: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}

  @override
  Widget build(BuildContext context) {
    //_emailController.text = "dineth@gmail.com";
    //_passwordController.text = "@hitatt";
    //_confirmPasswordController.text = "@hitatt";

    return Scaffold(
      backgroundColor: Colors.pink[50],
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                        color: Colors.pinkAccent,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Create Your Account",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ),
                    const SizedBox(height: 50),
                    // Username TextField
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: "User Name*",
                        border: OutlineInputBorder(),
                        hintText: "Enter your username",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your username";
                        }
                        /*if (value.length < 3) {
                          return "Username must be at least 3 characters long";
                        }*/
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Email TextField
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: "E-mail*",
                        border: OutlineInputBorder(),
                        hintText: "Enter your email",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your email";
                        }
                        final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
                        if (!emailRegex.hasMatch(value)) {
                          return "Please enter a valid email";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Password TextField
                    TextFormField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Password*",
                        border: OutlineInputBorder(),
                        hintText: "Password (at least 6 characters)",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please enter your password";
                        }
                        if (value.length < 6) {
                          return "Password must be at least 6 characters long";
                        }
                        final specialCharRegex =
                            RegExp(r'[!@#$%^&*(),.?":{}|<>]');
                        if (!specialCharRegex.hasMatch(value)) {
                          return "Password must include at least one special character";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    // Confirm Password TextField
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: "Confirm Password*",
                        border: OutlineInputBorder(),
                        hintText: "Re-enter your password",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Please confirm your password";
                        }
                        if (value != _passwordController.text) {
                          return "Passwords do not match";
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 25),
                    // Sign Up Button
                    Center(
                      child: SizedBox(
                        width: 130,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // If the form is valid, navigate to the SignIn screen

                              _login();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.pinkAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // OR Divider
                    const Text(
                      "or",
                      style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0), fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    // Social Media Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _socialLoginButton(
                          'Facebook',
                          Colors.black,
                          Image.asset('assets/images/fb.png', height: 20),
                          () async {
                            const url = 'https://www.facebook.com';
                            await _launchURL(url);
                          },
                        ),
                        const SizedBox(width: 16),
                        _socialLoginButton(
                          'Google',
                          Colors.black,
                          Image.asset('assets/images/google.png', height: 20),
                          () async {
                            const url = 'https://www.google.com';
                            await _launchURL(url);
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    // Log In Text
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyApp(),
                          ),
                        );
                      },
                      child: const Text.rich(
                        TextSpan(
                          text: "Already have an account? ",
                          style: TextStyle(color: Colors.black54),
                          children: [
                            TextSpan(
                              text: "Log In",
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _socialLoginButton(
      String text, Color textColor, Widget icon, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon,
      label: Text(
        text,
        style: TextStyle(color: textColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
    );
  }
}
