import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news1_1/article_details_screen.dart';
import 'package:news1_1/forget_screen.dart';
import 'package:news1_1/ui/news/news_page.dart';
import 'package:news1_1/ui/auth/signup_screen.dart';
import 'package:news1_1/ui/news/post_screen.dart';
import 'package:news1_1/ui/splash_screen.dart';
import 'package:news1_1/ui/utils/utils.dart';
import 'package:news1_1/ui/widgets/round_button.dart';
import 'package:news1_1/ui/news/news_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  final emailContoller = TextEditingController();
  final passwordContoller = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
    emailContoller.dispose();
    passwordContoller.dispose();
  }

  void login() {
    setState(() {
      loading = true;
    });
    _auth
        .signInWithEmailAndPassword(
            email: emailContoller.text,
            password: passwordContoller.text.toString())
        .then((value) {
      Utils().toastMessage(value.user!.email.toString());
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => NewsPage()));
      setState(() {
        loading = false;
      });
    }).onError((error, stackTrace) {
      debugPrint(error.toString());
      Utils().toastMessage(error.toString());
      setState(() {
        loading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            automaticallyImplyLeading: false,
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign In',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Text(
                  'Follow the simple steps',
                  style: TextStyle(fontSize: 18, color: Colors.blue),
                ),
                SizedBox(height: 60),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: emailContoller,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          prefixIcon: Icon(Icons.alternate_email),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter email';
                          }
                          // Check if the email format is valid
                          if (!_isValidEmail(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        keyboardType: TextInputType.text,
                        controller: passwordContoller,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          prefixIcon: Icon(Icons.lock_open),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter password';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 40),
                RoundButton(
                  title: 'Login',
                  loading: loading,
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      login();
                      // Form is valid, proceed with login
                    }
                  },
                ),
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ForgotPasswordScreen()));
                      },
                      child: Text('Forgot Password')),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()));
                        },
                        child: Text('Sign up'))
                  ],
                ),
                SizedBox(height: 40), // Adjusted width
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 70),
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text("By Signing In, you agree to our "),
                      GestureDetector(
                        onTap: () {
                          // Add navigation to Terms of Service screen
                        },
                        child: Text(
                          "Terms of Services",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Text(" and "),
                      GestureDetector(
                        onTap: () {
                          // Add navigation to Privacy Policy screen
                        },
                        child: Text(
                          "Privacy Policy",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.blue, // Make it look like a link
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  // Function to validate email format using regex
  bool _isValidEmail(String email) {
    // Regular expression to match a valid email format
    // This regex is a simplified version and may not cover all edge cases
    RegExp emailRegex =
        RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'); // Modify as needed
    return emailRegex.hasMatch(email);
  }
}
