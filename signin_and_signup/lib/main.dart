import 'package:flutter/material.dart';
import 'signin.dart';
import 'signup.dart';

void main() {
  runApp( const MyApp());
}

class  MyApp extends StatelessWidget {
  const MyApp({super.key}) ;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Email Sign In/Up',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SignInPage(),
        '/signup': (context) => const SignUpPage(),
      },
    );
  }
}
