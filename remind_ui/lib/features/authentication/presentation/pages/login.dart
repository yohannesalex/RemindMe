import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  final String email;
  final String password;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  Login({super.key, this.email = '', this.password = ''})
      : _emailController = TextEditingController(text: email),
        _passwordController = TextEditingController(text: password);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 161, 201, 234),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 161, 201, 234),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3),
                  border: Border.all(
                    color: Colors.blue, // Border color
                    width: 1, // Border width
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Shadow color
                      spreadRadius: 2, // Spread radius
                      blurRadius: 5, // Blur radius
                      offset: const Offset(
                          0, 2), // Shadow offset (elevation effect)
                    ),
                  ],
                ),
                child: const Text(
                  'Remind Me',
                  style: TextStyle(
                    fontFamily: 'CaveatBrush', // Specify the font family
                    fontSize: 40.0, // Font size
                    fontWeight: FontWeight.w500, // Font weight
                    color: Color.fromARGB(255, 59, 86, 243), // Text color
                    height: 117.41 /
                        100.89, // Line height (multiplier of font size)

                    textBaseline: TextBaseline.alphabetic,
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              const Text(
                'Wellcome Back',
                style: TextStyle(
                  fontFamily: 'CaveatBrush', // Specify the font family
                  fontSize: 45.0, // Font size
                  fontWeight: FontWeight.w500, // Font weight
                  color: Color.fromARGB(255, 59, 86, 243), // Text color
                  height:
                      117.41 / 100.89, // Line height (multiplier of font size)

                  textBaseline: TextBaseline.alphabetic,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Login into your account',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20),
              ),
              const SizedBox(
                height: 30,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  "Email",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: 300,
                  height: 35,
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(
                                255, 90, 1, 1), // Slightly visible border color
                            width: 0.1, // Border width
                          ),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 111, 107, 107))),
                  ),
                ),
              ]),
              const SizedBox(
                height: 15,
              ),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  "Password",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: 300,
                  height: 35,
                  child: TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(
                                255, 90, 1, 1), // Slightly visible border color
                            width: 0.1, // Border width
                          ),
                        ),
                        hintStyle: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Color.fromARGB(255, 111, 107, 107))),
                  ),
                ),
              ]),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        const Color.fromARGB(255, 53, 53, 240), // Button color
                    padding: const EdgeInsets.symmetric(
                        horizontal: 110.0, vertical: 5.0), // Custom padding
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0), // Button shape
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    'SIGN IN',
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white),
                  )),
              const SizedBox(
                height: 90,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Don't  have an account?",
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 40, 38, 38)),
                  ),
                  TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 18, 33, 197)),
                      ))
                ],
              )
            ],
          ),
        ));
  }
}
