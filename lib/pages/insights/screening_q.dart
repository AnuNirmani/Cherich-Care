import 'package:cherich_care_2/pages/home_page.dart';
import 'package:cherich_care_2/pages/insights/insights.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class ScreeningQ extends StatefulWidget {
  @override
  _ScreeningQState createState() => _ScreeningQState();
}

class _ScreeningQState extends State<ScreeningQ> {
  final DatabaseReference _database = FirebaseDatabase.instanceFor(
    app: Firebase.app(),
    databaseURL: 'https://cherishcarecare-default-rtdb.firebaseio.com'
  ).ref();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Map<String, dynamic> responses = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadResponses();
  }

  Future<void> _loadResponses() async {
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        DatabaseEvent event = await _database
          .child('users')
          .child(currentUser.uid)
          .child('quiz_responses')
          .once();

        if (event.snapshot.value != null) {
          setState(() {
            responses = Map<String, dynamic>.from(event.snapshot.value as Map);
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print('Error loading responses: $e');
      setState(() => isLoading = false);
    }
  }

  String _getQuestionText(String questionId) {
    switch(questionId) {
      case 'q01':
        return 'Have you had breast cancer?';
      case 'q02':
        return 'When were you born?';
      case 'q05':
        return 'Have you entered menopause yet?';
      case 'q06':
        return 'Did you start your period before age 11, or entered menopause after age 55?';
      case 'q07':
        return 'Have you ever given birth?';
      case 'q08':
        return 'Have  you ever taken Hormone Replacement Therapy (HRT)?';
      case 'q09':
        return 'Do you smoke, or drink alcohol regularly?';
      case 'q10':
        return 'Are you overweight?';
      case 'q11':
        return 'How much do you exercise a day?';
      case 'q12':
        return 'Has your mammography report said you have dense breasts?';
      case 'q14':
        return 'Do you have either of those gene mutation risks?';
      case 'q15':
        return 'Are you of Ashkenazi Jewish descent';
      case 'q16':
        return 'Any blood relatives with breast or ovarain cancer';
      case 'q17':
        return 'Have you tested positive for a BRCA genetic mutation?';
      case 'q18':
        return 'Have you had a mastectomy?';
      default:
        return 'Question $questionId';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Quiz Responses",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.pinkAccent ),
          onPressed: () => Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => ScreeningQ()),
            (route) => false,
          ),
        ),
      ),
      backgroundColor: Colors.pink[50],
      body: isLoading 
        ? const Center(child: CircularProgressIndicator())
        : responses.isEmpty
          ? const Center(child: Text('No responses found'))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: responses.length,
                    itemBuilder: (context, index) {
                      String questionId = responses.keys.elementAt(index);
                      dynamic response = responses[questionId];
                      
                      return Card(
                        margin: const EdgeInsets.only(bottom: 16),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _getQuestionText(questionId),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Answer: ${response['response']}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              if (response['age'] != null) ...[
                                const SizedBox(height: 4),
                                Text(
                                  'Age: ${response['age']}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Center(
                    child: SizedBox(
                      width: 100, // Small fixed width
                      height: 36, // Small height
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.pinkAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                          );
                        },
                        child: const Text(
                          'OK',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}