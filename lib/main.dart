import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news1_1/ui/Provider/theme_changer_provider.dart';
import 'package:news1_1/ui/navbar.dart';
import 'package:news1_1/ui/news/news_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ui/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCLS0XgXzgAQsXheUrrpdIxQZxJvLs_wQg',
          appId: '1:723740415709:android:2d2d620622403cc790ad34',
          messagingSenderId: '723740415709',
          projectId: 'news-ca90d'));

  // Initialize Shared Preferences for theme settings
  final prefs = await SharedPreferences.getInstance();

  // Run the app
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs})
      : super(key: key); // Constructor with prefs

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeChanger()..initTheme(prefs), // Initialize theme
      builder: (context, child) {
        final themeChanger = Provider.of<ThemeChanger>(context);
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          themeMode: themeChanger.themeMode,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
          ),
          home: SplashScreen(),
        );
      },
    );
  }
}
