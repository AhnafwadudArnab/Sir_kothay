import 'package:email_validator/email_validator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


import '../Dashboards/D1.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: ClipRRect(
          borderRadius: BorderRadius.circular(45.0),
          child: Image.asset('assets/sirkothayLogo.png', height: 75),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.facebook, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.hub, color: Colors.pink),
            onPressed: () {
              // Add your onPressed code here!
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/gradientcolor.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          if (kIsWeb)
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            )
          else
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
            ),
          Container(
            margin: const EdgeInsets.only(top: 22.0, left: 20.0, right: 20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const TextPic(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            spreadRadius: 2.0,
                            blurRadius: 10.0,
                            color: Colors.black.withOpacity(0.1),
                          ),
                        ],
                      ),
                      child: const LoginFormWidget(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TextPic extends StatelessWidget {
  const TextPic({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 42.0),
      child: Column(
        children: [
          Image.asset('assets/01-removebg-preview.png', height: 210),
        ],
      ),
    );
  }
}

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginFormWidgetState createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController retypePass = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    retypePass.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.79,
      width: MediaQuery.of(context).size.width,
      // color: const Color.fromARGB(141, 0, 0, 0).withOpacity(0.3),
      child: Form(
        key: _formKey,
        child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 30.0),
          // Name field
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(
              labelText: 'Name',
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.person, color: Colors.black),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your name';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          // Email field
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              labelStyle: TextStyle(color: Colors.black),
              prefixIcon: Icon(Icons.email, color: Colors.black),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!EmailValidator.validate(value)) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          // Password field
          TextFormField(
            controller: passwordController,
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Password',
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }

              if (value.length < 6) {
                return 'Password must be at least 6 characters long';
              }
              return null;
            },
          ),
          const SizedBox(height: 16.0),
          // Re-type Password field
          TextFormField(
            controller: retypePass,
            obscureText: isPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Re-type Password',
              labelStyle: const TextStyle(color: Colors.black),
              prefixIcon: const Icon(Icons.lock, color: Colors.black),
              suffixIcon: IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  color: Colors.black,
                ),
                onPressed: () {
                  setState(() {
                    isPasswordVisible = !isPasswordVisible;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              if (value != passwordController.text) {
                return 'Passwords do not match';
              }
              return null;
            },
          ),
          const SizedBox(height: 24.0),
            ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 96, 145, 219),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
              // Perform registration logic
                Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => D1Page(
                  name: nameController.text,
                  email: emailController.text,
                  bio: '',
                  organization: '',
                  phone: '',
                  designation: '',
                  roomNumber: '',
                  ),
                ),
                );
              }
            },
            child: const Text(
              'Sign Up',
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            ),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(color: Colors.black),
                ),
                SizedBox(width: 4),
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }
}
