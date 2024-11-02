import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/constant/privacy.dart';
import '../../../../core/validation/input_validation.dart';
import '../../domain/entity/signup_entity.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import '../bloc/auth_state.dart';
import '../widget/snackbar.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  bool _isChecked = false;
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 228, 240, 240),
              Color(0xFFFFEBEE),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Scaffold(
          backgroundColor: Color(0xFFFFEBEE),
          appBar: AppBar(
            backgroundColor: Color.fromARGB(255, 242, 189, 172),
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.chevron_left_rounded,
                color: Colors.blue,
                size: 30,
              ),
            ),
            actions: const [
              Text(
                'Remind me',
                style: TextStyle(
                  fontFamily: 'CaveatBrush',
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 59, 86, 243),
                ),
              ),
              SizedBox(width: 20),
            ],
          ),
          body: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthLoadingState) {
                const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is SignUpSuccessState) {
                context.read<AuthBloc>().add(GetMeEvent());
                Navigator.pushReplacementNamed(context, '/home');
              } else if (state is SignUpErrorState) {
                SnackBarHelper.showCustomSnackBar(
                    context, 'user with this email already exists');
              }
            },
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      'Create your account',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          _buildTextField(
                            label: 'Username',
                            hint: 'ex:Yohannes',
                            controller: _nameController,
                            validator: (value) {
                              if (!Valid.isName(value!)) {
                                return "Username must be at least 3 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Email',
                            hint: 'ex:johnsmith@gmail.com',
                            controller: _emailController,
                            validator: (value) {
                              if (!Valid.isEmail(value!)) {
                                return "Please enter a valid email format";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Password',
                            hint: 'ex:pass1234',
                            controller: _passwordController,
                            validator: (value) {
                              if (!Valid.isPassword(value!)) {
                                return "Password must be at least 8 characters";
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                          const SizedBox(height: 15),
                          _buildTextField(
                            label: 'Confirm Password',
                            hint: 'ex:pass1234',
                            controller: _confirmPasswordController,
                            validator: (value) {
                              if (!Valid.ismatch(
                                  value!, _passwordController.text)) {
                                return "Password does not match";
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value ?? false;
                            });
                          },
                        ),
                        const Text(
                          'I understood the terms and policy',
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 35, 34, 34),
                          ),
                        ),
                        GestureDetector(
                          onTap: _showTermsAndPrivacyDialog,
                          child: const Text(
                            '  terms & policy',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 17, 30, 178),
                            ),
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 53, 53, 240),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 110.0,
                          vertical: 5.0,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onPressed: () {
                        if (_isChecked == false) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text(
                                    'Please confirm the terms and policy')),
                          );
                        } else if (_formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(SignUpEvent(SignUpEntity(
                              email: _emailController.text,
                              name: _nameController.text,
                              password: _passwordController.text)));
                        }
                      },
                      child: const Text(
                        'SIGN UP',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Have an account?',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 45, 43, 43),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color.fromARGB(255, 17, 30, 178),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required TextEditingController controller,
    required String? Function(String?) validator,
    bool obscureText = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            width: 300,
            child: TextFormField(
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                border: const OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color.fromARGB(255, 90, 1, 1),
                    width: 0.1,
                  ),
                ),
                hintText: hint,
                hintStyle: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: Color.fromARGB(255, 111, 107, 107),
                ),
                errorStyle: const TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
              validator: validator,
            ),
          ),
        ],
      ),
    );
  }

  void _showTermsAndPrivacyDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Terms and Privacy Policy"),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Terms of Service"),
                const SizedBox(height: 10),
                privacy.displayService(),
                const SizedBox(height: 20),
                const Text("Privacy Policy"),
                const SizedBox(height: 10),
                privacy.displayPrivacy()
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
