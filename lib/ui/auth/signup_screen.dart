import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news1_1/ui/utils/utils.dart';

// import 'package:untitled1/utils/utils.dart';
import '../widgets/round_button.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void signUp() {
    setState(() {
      loading = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sign Up',
                      textAlign: TextAlign.start,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Follow the simple steps',
                      style: TextStyle(fontSize: 18, color: Colors.black54),
                    ),
                    SizedBox(height: 60), // Adjusted height
                    TextFormField(
                      keyboardType: TextInputType.name,
                      // controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Username',
                        prefixIcon: Icon(Icons.person_2_outlined),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter Username';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20), // Adjusted height
                    TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        prefixIcon: Icon(Icons.alternate_email),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Enter email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20), // Adjusted height
                    TextFormField(
                      keyboardType: TextInputType.text,
                      controller: passwordController,
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
              SizedBox(height: 60),
              // Adjusted height
              RoundButton(
                title: 'Sign up',
                loading: loading,
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    setState(() {
                      loading = true;
                    });
                    _auth
                        .createUserWithEmailAndPassword(
                      email: emailController.text.toString(),
                      password: passwordController.text.toString(),
                    )
                        .then((value) {
                      setState(() {
                        loading = false;
                      });
                    }).onError((error, stackTrace) {
                      Utils().toastMessage(error.toString());
                      setState(() {
                        loading = false;
                      });
                    });
                  }
                },
              ),
              SizedBox(height: 20),
              // Adjusted height
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
              SizedBox(height: 40), // Adjusted width
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 60),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    Text("By Signing Up, you agree to our "),
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
      ),
    );
  }
}
