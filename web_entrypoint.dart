import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:cherich_care_2/main.dart'; // Import your main application file

void main() {
  setUrlStrategy(PathUrlStrategy()); // Use path-based URL for better routing
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Web App',
      theme: ThemeData(
        fontFamily: 'Roboto', // Ensure the app uses Roboto
        primarySwatch: Colors.pink,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Welcome to Flutter Web"),
        ),
        body: const Center(
          child: Text("Hello, Web!"),
        ),
      ),
    );
  }
}
