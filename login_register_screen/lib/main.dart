import 'package:flutter/material.dart';
import 'package:login_register_screen/screens/login_register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login & Register Screens',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: LoginRegisterScreen());
  }
}
