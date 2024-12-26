import 'package:flutter/material.dart';

class Rf1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Your Age",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf1.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n Risk increases for breast cancer as you age. Unless you have found the fountain of everlasting youth, it's important to keep abreast of your health throughout your life. The statistic of 1-in-8 women getting diagnosed with breast cancer in their lifetime can be explained this way:\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "Imagine you are in a room with 8 women all of whom are over the age of 70. Statistically speaking, one of those 8 women would have had breast cancer at some point in her life. That is what is meant by lifetime risk for breast cancer. Now, if you went next door to a room full of women who were all aged 30, statistically speaking, you would need 204 women in that room before one of them would have had breast cancer. This is because risk is less for younger women than older women.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}










class Rf2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Period Tools",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf2.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n The more periods you've had, the more estrogen you have been exposed to, which can increase your risk (like starting your period before age 12).\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}









class Rf3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Pills & Hormons",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf3.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n Not all hormone pills or birth control pills increase your risk for breast cancer, but some can. Talk to your doctor about whether the medications you are taking have a breast cancer risk associated with them.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}












class Rf4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Dense Breast",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf4.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n Half of women over the age of 40 (in the USA) have dense breasts, which is more common in young and thin women. This isn't something you can 'feel' but is revealed on your mammogram report",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nDense breasts can make it difficult for mammograms to see cancer. Talk to your doctor about additional screening options such as Automated Breast Ultrasound (ABUS) or a breast MRI",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nWhat is breast density? \nEvery woman has a unique breast density, which is determined by measuring the amount of glandular tissue, fibrous tissue, and fatty tissue within the breast, Dense breast tissue has more fibrous and glandular tissue than fatty tissue.",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}








class Rf5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Lumpy Breast",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf5.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n Some breasts are lumpy, which is common. The medical term is 'fibrocystic'. This can cause breast pain, tenderness and lumpiness--but it doesn't increase your risk for breast cancer.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nHowever, 'atypical hyperplasia', which is found through biopsy, is a build-up of abnormal cells in the breast. Over time, if atypical hyperplasia cells keep dividing and become more abnormal, they can turn into breast cancer. This is why additional screening is recommended.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}










class Rf6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Genetic Mutation",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf6.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nA family history of breast cancer, particularly if it is a first-degree relative (such as a mother or sister), increases your risk because you may share a genetic mutation. However, 85-90% of people with breast cancer are the first in their family to have it. Talk to your doctor about genetic testing if it's a concern.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nYou are more likely to have an abnormal breast cancer gene if you have:",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "* blood relatives (grandmothers, mother, sisters, aunts) on either your mother's or father's side of the family who had breast cancer before age 50 \n* both breast and ovarian cancer on the same side of the family or in a single individual \n* a relative with 'triple-negative' breast cancer (a specific type of breast cancer that affects about 10-20% of patients) \n* other cancers in your family in addition to breast, such as prostate, melanoma, pancreatic, stomach, uterine, thyroid, colon, and/or sarcoma \n* women in your family with cancer in both breasts \n* Ashkenazi Jewish (Eastern European) heritage \n* African American heritage and diagnosed with breast cancer at age 35 or younger \n* a man in your family who has had breast cancer \n* an abnormal breast cancer gene in your family (such as: BRCA1, BRCA2, BTEN, TP53, PALB2, STK11, CHEK2, CDH1, NBN, BRIP1, BARD1, ATM) \n* had radiation to the chest before age 30 (while breasts are still developing) can increase the risk of breast cancer due to possible mutations",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nNote: If one family member has an abnormal breast cancer gene, it does not mean that all family members will have it. Individual testing is needed.",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}









class Rf7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Being Overweight",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf7.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nDid you know that body fat produces and stores estrogen? Your risk increases if you are overweight after menopause.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}











class Rf8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Alcohol + Smoking",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf8.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n Consuming moderate to increased levels of alcohol, as well as smoking cigarettes, may increase your risk for breast cancer.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}












class Rf9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Lack of Exercise",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      // Set background color for the whole page
      backgroundColor: Colors.pink[50],
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image at the top
              Center(
                child: Image.asset(
                  'assets/images/rf9.png', // Replace with your image asset path
                  width: 150, // Adjust width as needed
                  height: 150, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n Not exercising regularly, or being stationary for long periods of time can also contribute to your risk for breast cancer.\n",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),             
              
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
