import 'package:cherich_care_2/pages/insights/rf1.dart';
import 'package:flutter/material.dart';


class RiskFactors extends StatelessWidget {
  final List<RiskFactorItem> riskFactors = [
    RiskFactorItem(
      imagePath: "assets/images/rf1.png",
      title: "Your Age",
      subtitle: "What are your odds?",
      page: Rf1(), // New page
    ),
    RiskFactorItem(
      imagePath: "assets/images/rf2.png",
      title: "Period Tools",
      subtitle: "How much estrogen have you had?",
      page: Rf2(),
    ),
    RiskFactorItem(
      imagePath: "assets/images/rf3.png",
      title: "Pills & Hormones",
      subtitle: "How much estrogen have you had?",
      page: Rf3(),
    ),
    RiskFactorItem(
      imagePath: "assets/images/rf4.png",
      title: "Dense Breast",
      subtitle: "Breast type",
      page: Rf4(),
    ),
    RiskFactorItem(
      imagePath: "assets/images/rf5.png",
      title: "Lumpy Breast",
      subtitle: "Breast type",
      page: Rf5(),
    ),
    RiskFactorItem(
      imagePath: "assets/images/rf6.png",
      title: "Genetic Mutation",
      subtitle: "Breast type",
      page: Rf6(),
    ),
    RiskFactorItem(
      imagePath: "assets/images/rf7.png",
      title: "Being Overweight",
      subtitle: "Lifestyle Choices",
      page: Rf7(),
    ),
    RiskFactorItem(
      imagePath: "assets/images/rf8.png",
      title: "Alcohol + Smoking",
      subtitle: "Lifestyle Choices",
      page: Rf8(),
    ),
    RiskFactorItem(
      imagePath: "assets/images/rf9.png",
      title: "Lack of Exercise",
      subtitle: "Lifestyle Choices",
      page: Rf9(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Colors.pinkAccent,
        title: const Text(
          "9 Risk Factors",
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
      backgroundColor: Colors.pink[50],
      body: ListView.builder(
        itemCount: riskFactors.length,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = riskFactors[index];
          return _buildRiskFactorCard(context, item);
        },
      ),
    );
  }

  Widget _buildRiskFactorCard(BuildContext context, RiskFactorItem item) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.pink[50],
          radius: 30,
          child: Image.asset(
            item.imagePath,
            fit: BoxFit.contain,
            width: 40,
            height: 40,
          ),
        ),
        title: Text(
          item.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        subtitle: Text(
          item.subtitle,
          style: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.pinkAccent,
          size: 20,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => item.page),
          );
        },
      ),
    );
  }
}

// Risk Factor Data Model
class RiskFactorItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final Widget page;

  RiskFactorItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.page,
  });
}
