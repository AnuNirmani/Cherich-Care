import 'package:cherich_care_2/pages/profile/profile.dart';
import 'package:flutter/material.dart';

class ChangeNameEmail extends StatefulWidget {
  const ChangeNameEmail({super.key});

  @override
  State<ChangeNameEmail> createState() => _ChangeNameEmailState();
}

class _ChangeNameEmailState extends State<ChangeNameEmail> {
  // Controllers for the text fields
  final TextEditingController _nameController = TextEditingController(text: 'Ashini');
  final TextEditingController _emailController = TextEditingController(text: 'ashini@gmail.com');
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          'Change Details',
          style: TextStyle(
            fontSize: 24,
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
      backgroundColor: Colors.pink[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Assign form key
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Name field
              const Text(
                '\n    Name',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  /*if (value.length < 2) {
                    return 'Name must be at least 2 characters long';
                  }
                  if (!RegExp(r'^[a-zA-Z\s]+$').hasMatch(value)) {
                    return 'Name can only contain alphabets and spaces';
                  }*/
                  return null;
                },
              ),
              const SizedBox(height: 16),

              // Email field
              const Text(
                '    E-mail',
                style: TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(255, 0, 0, 0),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+$').hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 32),

              // Save button
              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Save action and navigate to Profile page
                        print('Name: ${_nameController.text}');
                        print('Email: ${_emailController.text}');
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Profile()),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
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
