import 'package:chatgpt/header/termsandconditions.dart';
import 'package:chatgpt/screen/login.dart';
import 'package:flutter/material.dart';
import 'dataprivacy.dart';

class PopupMenuButtonPage extends StatelessWidget {
  const PopupMenuButtonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'terms',
          child: ListTile(
            leading: Icon(Icons.description),
            title: Text('Terms and Conditions'),
          ),
        ),
        const PopupMenuItem<String>(
          value: 'privacy',
          child: ListTile(
            leading: Icon(Icons.security),
            title: Text('Data Privacy'),
          ),
        ),
      ],
      icon: const Icon(Icons.menu), // Icon to display on the button
      onSelected: (String value) {
        // Logic for handling item selection
        if (value == 'login') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const LoginScreen(),
            ),
          );
        }
        else if (value == 'privacy') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DataPrivacyPage(),
            ),
          );
        } else if (value == 'terms') {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TermsAndConditionsPage(),
            ),
          );
        }
      },
      elevation: 8, // Elevation of the menu
      color: Colors.white, // Background color of the menu
      offset: const Offset(0, 0), // Offset to position the menu
    );
  }
}
