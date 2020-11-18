import 'package:flutter/material.dart';
import 'package:listease/Screens/listList_screen.dart';
import 'package:listease/utilities/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ListEase',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        accentColor: kPinkButtonColour,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ListListScreen(),
    );
  }
}
