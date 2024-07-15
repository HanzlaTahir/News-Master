// import 'dart:async';
// import 'package:flutter/material.dart';
//
// import 'main.dart'; // Import your main app file here
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       Duration(seconds: 2), // Adjust the duration as per your preference
//           () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => MyApp()), // Replace MyApp() with your main app widget
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Image.asset('images/splash.jpeg'), // Path to your splash screen image
//       ),
//     );
//   }
// }
//************************************************************************
// import 'dart:async';
// import 'package:flutter/material.dart';
// // import 'package:news1_1/firebase_services/splash_services.dart';
//
// // import 'package:flutter_news_app/news_page.dart';
// import 'package:news1_1/news_page.dart';
//
// import '../news_page.dart'; // Import your news page file here
//
// class SplashScreen extends StatefulWidget {
//   @override
//   _SplashScreenState createState() => _SplashScreenState();
// }
//
// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     Timer(
//       Duration(seconds: 4), // Adjust the duration as per your preference
//       () {
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(
//               builder: (context) => NewsPage()), // Navigate to the home screen
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//               image: AssetImage('images/splash.jpeg'), fit: BoxFit.fill),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:news1_1/firebase_services/splash_services.dart';

import 'navbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServicess splashScreen = SplashServicess();

  get prefs => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    splashScreen.isLogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/splash.jpeg'), fit: BoxFit.fill),
        ),
      ),
    );
  }
}
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: Text('News Master'),
//       ),
//     );
//   }
// }
