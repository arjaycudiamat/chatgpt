import 'package:chatgpt/header/popup_menu.dart';
import 'package:flutter/material.dart';
import 'package:chatgpt/screen/register.dart';

import 'login.dart';

class TermsAndConditionsPageAccept extends StatelessWidget {
  const TermsAndConditionsPageAccept({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), // Adjust the height as needed
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 184, 12),
          centerTitle: true,
          title: const Text('Agreement'),
          automaticallyImplyLeading: true, // Enable the default back button
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              // Navigate to the login page when back button is pressed
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
          ),
          actions: const [
            PopupMenuButtonPage(),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 6, 184, 12),
            ], // Adjust the gradient colors as needed
            center: Alignment.bottomCenter,
            radius: 1,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100.0),
                  const Column(
                    children: [
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'By registering your Account, you agree to our',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.0,
                              fontWeight: FontWeight.normal,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Privacy Policy and Terms and Conditions',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25.0,
                              fontWeight: FontWeight.w700,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 100.0),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 16),
                    child: MaterialButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return const RegisterScreen();
                          }),
                        );
                      },
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.all(16),
                      textColor: const Color(0xffffffff),
                      minWidth: MediaQuery.of(context).size.width,
                      child: Container(
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromARGB(255, 27, 113, 26),
                        ),
                        child: const Center(
                          child: Text(
                            "AGREE",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.normal,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
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
