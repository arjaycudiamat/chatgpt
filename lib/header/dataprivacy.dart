import 'package:chatgpt/header/popup_menu.dart';
import 'package:flutter/material.dart';

class DataPrivacyPage extends StatelessWidget {
  const DataPrivacyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text('Data Privacy'),
          actions: const [
            PopupMenuButtonPage(),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Colors.white, Colors.green], // Adjust the gradient colors as needed
            center: Alignment.center,
            radius: 0.8,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(0.0),
            child: Container(
              alignment: Alignment.center,
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  Column(
                    children: [
                      SingleChildScrollView(
                        padding: EdgeInsets.all(25),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'We value your privacy and are committed to protecting your personal information. This Data Privacy policy explains how we expect, use, and share your information when you use our application, in accordance with the Data Privacy Act of 2012.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '1. Information We Collect',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'We may collect various types of information, including:',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('- Personal information such as your name, email address, and contact details.'),
                                  Text('- Usage information such as your interactions with the application and preferences.'),
                                  Text('- Device information such as your IP address, device type, and operating system.'),
                                ],
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '2. How We Use Your Information',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'We may use your information for various purposes, including:',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('- Providing and improving our application and services.'),
                                  Text('- Personalizing your experience and displaying relevant content.'),
                                  Text('- Engaging with you and responding to your inquiries.'),
                                  Text('- Analyzing usage trends and optimizing our application.'),
                                ],
                              ),
                            ),
                            // Add additional sections if needed
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
