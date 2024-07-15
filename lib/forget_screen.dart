import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:news1_1/ui/utils/utils.dart';

import 'ui/widgets/round_button.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(hintText: 'Email'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter Email to recover your account';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 40,
              ),
              RoundButton(
                title: 'Forgot Password',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    auth
                        .sendPasswordResetEmail(
                            email: emailController.text.toString())
                        .then((value) {
                      Utils().toastMessage(
                          'We have sent you an email to recover your password. Please check your email.');
                    }).catchError((error) {
                      Utils().toastMessage('Error: $error');
                    });
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
