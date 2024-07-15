// import 'dart:async';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:news1_1/news_page.dart';
// import 'package:news1_1/ui/auth/login_screen.dart';
//
// // import 'package:untitled1/ui/auth/login_screen.dart';
// //
// // import '../ui/firebase_database/post_screen.dart';
// // import '../ui/firebase_firestore/fire_store_list.dart';
//
// class SplashServices {
//   void isLogin(BuildContext context) {
//     final auth = FirebaseAuth.instance;
//
//     final user = auth.currentUser;
//
//     if (user != null) {
//       Timer(
//           const Duration(seconds: 3),
//           () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => NewsPage())));
//     } else {
//       Timer(
//           const Duration(seconds: 3),
//           () => Navigator.push(
//               context, MaterialPageRoute(builder: (context) => LoginScreen())));
//     }
//   }
// }
//********************************************

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:news1_1/ui/auth/login_screen.dart';
import 'package:news1_1/ui/auth/signup_screen.dart';
import 'package:news1_1/ui/news/news_page.dart';

class SplashServicess {
  void isLogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewsPage())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.push(context,
              MaterialPageRoute(builder: (context) => SignUpScreen())));
    }
  }
}
