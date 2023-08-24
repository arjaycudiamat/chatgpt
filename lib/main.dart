import 'package:chatgpt/screen/login.dart';
import 'package:chatgpt/splash/splash.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "3 P's Manual",
        initialRoute: '/',
        routes:{
        '/': (context) => const SplashScreen(),
        '/main': (context) => const LoginScreen(),
        }
    );
  }
}
