import 'package:flutter/material.dart';

class Sym1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Hard Lump",
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
                  'assets/images/sym1.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n The most common sign of breast cancer is a lump, deep in the breast. It often feels hard, like a lemon seed, and usually immovable. It can be any shape or size. A lump is not always easy to feel. If you have access to breast cancer screening use it-a mammogram can detect a lump long before it can be felt.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nMost lumps turn out to be harmless.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "Such as a fluid filled cyst or a fibroadenoma.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 255, 0, 0),
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





class Sym2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Thick Area",
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
                  'assets/images/sym2.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image
              // Main content text
              const Text(
                "\nYou may notice that a part of your breast feels different from the rest, being less 'squishy' and more 'dense'. This can be a normal part of menstruation or breastfeeding. However, a thickening in your breast that doesn't go away or gets worse could also be a sign of breast cancer.",
              textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nThe thickening can be in the skin (which is a sign of Inflammatory Breast Cancer) or deeper in the breast. This thickening is caused when cancer cells are blocking circulation in the breast (via blood or lymph vessels) or a tumor is growing near the surface of the skin. This is different from a hard lump, which is formed when cancer cells grow very close together.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nNote: This is not to be confused with 'breast density' which doesn't refer to how a breast feels. Breast density can only be determined through a mammography report.\n",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
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







class Sym3 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Dimple",
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
                  'assets/images/sym3.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nA dimple (or indentation) in the breast can happen when tight clothing leaves a temporary mark in the skin, or is caused by cellulite. But if a dimple in the breast doesn't move with the rest of your skin when you raise and lower your arms, gets worse, or appears on its own, it can be a sign of breast cancer.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nThis symptom is caused when a tumor (lump) deep in the breast pulls the skin and tissue inward causing the surface of the breast to indent. Sometimes this lump can be felt, sometimes it can't.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nA dimple can be more easily seen when lifting your arms up above your head to see if the whole breast skin moves with you as you raise and lower your arms. (Pro tip: Having a light source directly overhead can also help cast shadows to show indents more clearly too.)",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
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




class Sym4 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Nipple Crust",
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
                  'assets/images/sym4.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nCrust on the nipple can be a harmless skin condition, like eczema, or is a common problem with breastfeeding. But if skin remedies don't fix the problem, it could be a sign of breast cancer called 'Paget's disease.' This is when cancer cells spread inside the breast and live in the nipple creating a scab-like red or white crusted surface that can be sore and doesn't go away. It can also cause persistent itching,\n",
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





class Sym5 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Red or Hot",
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
                  'assets/images/sym5.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nTypically, this is an infection or a skin symptom common to developing breasts, breastfeeding or eczema. If time, antibiotics or other treatments don't improve the symptom, it could be a sign of Inflammatory Breast Cancer. This type of cancer blocks the flow of lymph in the breast, which causes swelling and redness but without an obvious hard lump. This may also make the breast feel warm or hot, or cause a burning sensation. The skin of the breast may also appear pink, reddish purple, or bruised.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nThis symptom may be difficult to see on a mammogram. Because inflammatory breast cancer is so aggressive, it can progress quickly. Don't hesitate to report a change If antibiotics don't clear up the symptoms, then it's best to see a breast specialist.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nNote: This is not the same as breast tenderness, which comes and goes with the menstrual cycle.skin punch biopsy This is where a piece of the breast skin and the tissue immediately underneath is sampled.",
                //textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
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






class Sym6 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "New Fluid ",
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
                  'assets/images/sym6.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nDischarge from the nipple is common and is harmless (benign) most of the time. It is usually related to developing breasts, infection, cysts, pregnancy, breastfeeding. However, if fluid is leaking from the breast outside of these changes, it is something that should be checked out, especially if it is clear or contains blood.\n",
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






class Sym7 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Skin Sores ",
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
                  'assets/images/sym7.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nBreast cancer can sometimes build up to the point that it breaks down the skin of the breast to form an open wound. Infection may cause a bad smell and/or leakage. This is usually accompanied by an obvious hard lump. This is an advanced sign of the disease, meaning it has been present for some time.\n",
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






class Sym8 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Bump",
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
                  'assets/images/sym8.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nSometimes a cancerous lump is on the surface of the breast. However, not all lumps and bumps are cancer. Many are cysts (fluid collections) or harmless benign lumps made of various tissue (fibroadenomas). Many women have lumpy, bumpy breasts. However, if it's something that is new, show a doctor.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nThis is not to be confused with an injury to the breast. A direct hit to the breast cannot cause cancer. Sometimes an injury can lead to a lump known as 'fat necrosis'. This is scar tissue that can form when the body naturally repairs the damaged fatty breast tissue.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const Text(
                "\nIf other tests are inconclusive, such as a mammogram or an ultrasound, looking at the cells from the lump under a microscope (done with a biopsy) can help to determine if it's cancer.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
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







class Sym9 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Growing Vein ",
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
                  'assets/images/sym9.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\n'Enlarged veins' is one of the rarer symptoms of breast cancer and is normally included in general 'other unusual changes' or 'skin changes' categories. Newly appearing blood vessels or veins are usually not a sign of cancer. More often it is connected to weight gain, breastfeeding, or Mondor's disease. However, if veins become more pronounced outside of these changes on the breast or near the collarbone (and sometimes accompanied with a swollenarm), this could be a sign of a breast cancer tumor drawing more blood to itself and the vein sweling in size to allow for additional blood flow.\n",
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







class Sym10 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "New shape or Size",
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
                  'assets/images/sym10.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nIt's common for one breast to be different in size and shape from the other. This kind of variety is what our bodies are known for. Breastfeeding can also cause changes in size or shape as a result of milk production. But if one breast changes size, flattens, swells, or droops unexpectedly-and doesn't seem to be connected to your menstruation cycle-this could be a sign of breast cancer.\n",
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







class Sym11 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "Sunken Nipple ",
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
                  'assets/images/sym11.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nRetracted nipples can be a normal shape of the breast (from when the breast was first developed). However, if you notice your nipple sinking, flattening, or turning, it could be a sign of a new breast cancer tumor forming underneath, pulling the nipple toward it as it grows.\n",
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










class Sym12 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold( 
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text(
          "'Orange Peel' Skin",
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
                  'assets/images/sym12.png', // Replace with your image asset path
                  width: 200, // Adjust width as needed
                  height: 200, // Adjust height as needed
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16), // Add spacing below the image

              // Main content text
              const Text(
                "\nWhen the skin of the breast looks like the dimpled skin of an orange, this is a symptom of breast cancer known as 'peau d'orange', (how the French say 'orange peel'). With peau d'orange, the breast swells to the point it causes hair follicles to look like lots of little dimples",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              const Text(
                "The skin may or may not change color. Peau d'orange is a sign of Inflammatory Breast Cancer. This type of cancer blocks the flow of lymph in the breast, which causes swelling and redness but without an obvious hard lump.\n",
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





