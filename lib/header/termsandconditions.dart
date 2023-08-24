import 'package:chatgpt/header/popup_menu.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), // Adjust the height as needed
        child: AppBar(
          backgroundColor: Colors.green,
          centerTitle: true,
          title: const Text('Terms and Conditions'),
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
                            Center(
                              child: Text(
                                'PERSONNEL POLICIES AND PROCEDURES MUTUAL AWARENESS AND AGREEMENT',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '1. I hereby acknowledge that I have read and understood the contents of this Institution’s Personnel Policies and Procedures Manual which includes policy memos, circulars and memoranda.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '2. The content provided in this application is for informational purposes only and should not be considered as professional advice.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '3. I believe that this manual will serve as a useful guide in my faithful compliance with and adherence to the policies and regulations contained herein, which are a reflection of the institution’s culture and values.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '4. Therefore, I do solemnly swear to abide by the policies and procedures to the best of my ability.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Text(
                              '5. I understand that failure to do so would result to disciplinary action or dismissal from employment.',
                              style: TextStyle(fontSize: 16),
                            ),
                            SizedBox(height: 16),
                            Text(
                              'INSTRUCTION:',
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Every staff/employee joining/had already joined this unit/office must read and understand the Personnel Policies and Procedures Manual and he/she must agree before registering the account. It is also encouraged that everyone shall refer to the manual and abides by the policies and procedures.',
                              style: TextStyle(fontSize: 16),
                            ),
                            Center(
                              child: Text(
                                'Accomplished form shall be included in the front page part of the Personnel Manual. All employees must renew signing in this form annually. Please make sure this form is available at the unit office any time needed.',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
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
