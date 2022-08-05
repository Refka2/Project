import 'package:flutter/material.dart';
import 'package:flutter1/ui/profile/views/edit_profile.dart';
import 'package:flutter1/ui/ui_utils/colors.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: lightGray,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const EditProfile(),
    );
  }
}


