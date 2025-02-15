import 'package:cherich_care_2/pages/home_page.dart';
import 'package:cherich_care_2/pages/insights/b_cancer_refs.dart';
import 'package:cherich_care_2/pages/insights/clinical_trials.dart';
import 'package:cherich_care_2/pages/insights/risk_assesment.dart';
import 'package:cherich_care_2/pages/insights/risk_factors.dart';
import 'package:cherich_care_2/pages/insights/screening_q.dart';
import 'package:flutter/material.dart';

class Insights extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Insights",
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: const Color.fromARGB(255, 255, 255, 255)),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false,
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.pink.shade50,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/insights.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 30),
                _customButton(context, 'Risk Factors', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RiskFactors()),
                  );
                }),
                _dotSeparator(),
                _customButton(context, 'Clinical Trials', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ClinicalTrials()),
                  );
                }),
                _dotSeparator(),
                _customButton(context, 'Breast Cancer References', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BCancerRefs()),
                  );
                }),
                _dotSeparator(),
                _customButton(context, 'Risk Assessment', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RiskAssesment()),
                  );
                }),
                _dotSeparator(),
                _customButton(context, 'Risk Assessment Responses', () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ScreeningQ()),
                  );
                }),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    "\nFor educational purposes only. Always talk to your doctor when making health decisions.\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _customButton(BuildContext context, String text, VoidCallback onPressed, {IconData? icon}) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.pinkAccent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
        ),
        padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        minimumSize: Size(double.infinity, 50),
      ),
      onPressed: onPressed,
      icon: icon != null ? Icon(icon, color: Colors.white) : Container(width: 0),
      label: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Widget _dotSeparator() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        '•••',
        style: TextStyle(
          color: Colors.pinkAccent,
          fontSize: 24
        ),
      ),
    );
  }
}