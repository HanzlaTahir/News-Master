// // This is a basic Flutter widget test.
// //
// // To perform an interaction with a widget in your test, use the WidgetTester
// // utility in the flutter_test package. For example, you can send tap and scroll
// // gestures. You can also use WidgetTester to find child widgets in the widget
// // tree, read text, and verify that the values of widget properties are correct.
//
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
//
// import 'package:news1_1/main.dart';
//
// void main() {
//   testWidgets('Counter increments smoke test', (WidgetTester tester) async {
//     // Build our app and trigger a frame.
//     await tester.pumpWidget(MyApp());
//
//     // Verify that our counter starts at 0.
//     expect(find.text('0'), findsOneWidget);
//     expect(find.text('1'), findsNothing);
//
//     // Tap the '+' icon and trigger a frame.
//     await tester.tap(find.byIcon(Icons.add));
//     await tester.pump();
//
//     // Verify that our counter has incremented.
//     expect(find.text('0'), findsNothing);
//     expect(find.text('1'), findsOneWidget);
//   });
// }

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:news1_1/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding
      .ensureInitialized(); // Ensure Flutter widgets are initialized

  // Set up mock SharedPreferences for your tests
  TestWidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({}); // Create an empty mock

  testWidgets('SplashScreen loads successfully', (WidgetTester tester) async {
    // Provide the mock SharedPreferences to MyApp
    final prefs =
        await SharedPreferences.getInstance(); // Get the mock instance
    await tester.pumpWidget(MyApp(prefs: prefs));

    // Find widgets you expect to exist in your SplashScreen
    expect(find.byType(AppBar), findsOneWidget); // Find an AppBar
    expect(find.text('Loading...'),
        findsOneWidget); // Or any other specific loading text

    // Add more expectations/checks if needed
  });
}
