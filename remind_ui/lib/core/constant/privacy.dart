import 'package:flutter/material.dart';

class Privacy {
  Text displayPrivacy() {
    return const Text(
      "At Remind Me, protecting your personal information is our priority. We collect and use your data solely to improve your experience, provide notifications, and ensure smooth functionality. We do not sell or share your personal information with third parties without consent, except as required by law.",
      style: TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  Text displayService() {
    return const Text(
        "Welcome to Remind Me! By using our app, you agree to our terms and conditions, which govern your use of the service. We are committed to delivering a reliable experience and continuously enhancing our features. Please use Remind Me responsibly, and note that misuse or unauthorized access may result in restricted access to our services.",
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w400,
        ));
  }
}

Privacy privacy = Privacy();
