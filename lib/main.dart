import 'package:cherich_care_2/firebase_options.dart';
import 'package:cherich_care_2/pages/auth/login_screean.dart';
// import 'package:cherich_care_2/services/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:cherich_care_2/pages/forget_password.dart';
// import 'package:cherich_care_2/pages/home_page.dart';
// import 'package:cherich_care_2/pages/sign_up.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>(); // Global key for the form

//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();

//   Future<void> _launchURL(String url) async {
//     if (await canLaunch(url)) {
//       await launch(url);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }

//   Future<void> login() async {
//     try {
//       print(_emailController.text + _passwordController.text);
//       Map<String, dynamic> result = await Auth().signInWithEmailAndPassword(
//           _emailController.text, _passwordController.text);
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => HomePage(),
//         ),
//       );
//     } on Exception catch (e) {
//       print(e);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error saving data: ${e.toString()}'),
//           backgroundColor: Colors.red,
//         ),
//       );
//     }
//   }


//   Widget _socialLoginButton(
//       String text, Color textColor, Widget icon, VoidCallback onPressed) {
//     return ElevatedButton.icon(
//       onPressed: onPressed,
//       icon: icon,
//       label: Text(
//         text,
//         style: TextStyle(color: textColor),
//       ),
//       style: ElevatedButton.styleFrom(
//         backgroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(8),
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//       ),
//     );
//   }
// }
