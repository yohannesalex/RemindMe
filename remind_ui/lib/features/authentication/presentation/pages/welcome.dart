import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Positioned.fill(
          child: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets/portrait-pretty-indonesian-asian-woman-600nw-2160212123.webp'), // Replace with your image path
            fit: BoxFit.cover,
          ),
        ),
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..scale(-1.0, 1.0), // Inverts the image horizontally
          child: Image.asset(
            'assets/portrait-pretty-indonesian-asian-woman-600nw-2160212123.webp',
            fit: BoxFit.cover,
          ),
        ),
      )),
      Positioned.fill(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Color(0xFFFFEBEE).withOpacity(1.0), // Full opacity
                Color(0xFFFFEBEE).withOpacity(0.5), // 50% opacity
              ],
            ),
          ),
        ),
      ),
      Column(
        children: [
          const SizedBox(
            height: 100,
          ),
          const Center(
            child: Text(
              'Remind Me',
              style: TextStyle(
                fontFamily: 'CaveatBrush', // Specify the font family
                fontSize: 75, // Font size
                fontWeight: FontWeight.w400, // Font weight
                color: Color.fromARGB(255, 7, 38, 214), // Text color
                height:
                    117.41 / 100.89, // Line height (multiplier of font size)
                // Letter spacing (converted to px)
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          const Center(
            child: Text(
              'Wellcome',
              style: TextStyle(
                fontFamily: 'CaveatBrush', // Specify the font family
                fontSize: 45, // Font size
                fontWeight: FontWeight.w400, // Font weight
                color: Color.fromARGB(255, 7, 38, 214), // Text color
                height:
                    117.41 / 100.89, // Line height (multiplier of font size)
                // Letter spacing (converted to px)
                textBaseline: TextBaseline.alphabetic,
              ),
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 76, 76, 242), // Button color
                padding: const EdgeInsets.symmetric(
                    horizontal: 110.0, vertical: 5.0), // Custom padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0), // Button shape
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text(
                'Register',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    const Color.fromARGB(255, 90, 90, 245), // Button color
                padding: const EdgeInsets.symmetric(
                    horizontal: 110.0, vertical: 5.0), // Custom padding
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0), // Button shape
                ),
              ),
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: const Text(
                '  Login  ',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              )),
        ],
      )
    ]));
  }
}
