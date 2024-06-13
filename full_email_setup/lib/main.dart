import 'package:flutter/material.dart';
import 'screens/login_screen.dart' ;
import 'screens/homescreen.dart' ;
import "./objectbox.dart" ;

late ObjectBox objectbox ;

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  objectbox = await ObjectBox.create() ;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SignInPage(),
      initialRoute: '/',
      routes: {
        '/homepage' : (context) => const HomeScreen(),
      }
    );
  }
}
