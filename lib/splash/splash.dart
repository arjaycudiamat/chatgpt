import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add any initialization or data loading code here
    // After a delay, navigate to the main screen
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/main');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 200.0), // Add padding to the container
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 6, 184, 12),
              Colors.yellow,
            ],
            center: Alignment.bottomCenter,
            radius: 2.2,
          ),
        ),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'Assets/Images/cardmri.jpeg',
                width: 150,
                height: 50,
              ),
              const SizedBox(height: 20), // Add some spacing between images
              Image.asset(
                'Assets/Images/PM.png',
                width: 350,
                height: 100,
              ),
            ],
          ),
        ),
      ),
    );
  }


}
