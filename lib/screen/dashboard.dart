import 'package:chatgpt/screen/chat_screen.dart';
import 'package:chatgpt/screen/login.dart';
import 'package:chatgpt/screen/profile.dart';
import 'package:chatgpt/services/apiservice.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DashboardScreen extends StatefulWidget {
  final String userId;

  const DashboardScreen({Key? key, required this.userId}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  bool isProfileButtonHovered = false;
  bool isChatButtonHovered = false;

  static Future<void> logout(BuildContext context) async {
    final url = Uri.parse('http://10.0.2.2:8000/logout'); // Update the server endpoint based on your requirements
    final response = await http.post(url);

    if (response.statusCode == 200) {
      // Logout successful, user session cleared on the server
      clearLocalUserData(); // Example: Clear local user data or state
      navigateToLoginScreen(context); // Example: Navigate to the login screen
      displayLogoutSuccessMessage(context); // Example: Display a success message to the user
    } else {
      final errorMessage = response.body;
      throw Exception('Logout failed: $errorMessage');
    }
  }

  void _showLoading() {
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
      });
    });
  }

  void _hideLoading() {
    setState(() {
    });
  }

  static void clearLocalUserData() {
    // Perform actions to clear local user data or state
    // Example: Clearing stored user ID, tokens, or preferences

    // Clear stored user ID
    String? userId;

    // Assign default values to the variables if they are null
    userId ??= '';
  }

  static void navigateToLoginScreen(BuildContext context) {
    // Perform navigation to the login screen
    // Example: Using Navigator to push the login screen route
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
  }

  static void displayLogoutSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logout successful'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), // Adjust the height as needed
        child: AppBar(
          automaticallyImplyLeading: false, // Hide the back button
          backgroundColor: const Color.fromARGB(255, 6, 184, 12),
          centerTitle: true,
          title: const Text('Dashboard'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings_power),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Row(
                      children: [
                        Icon(Icons.settings_power),
                        SizedBox(width: 10),
                        Text(
                          'Confirmation',
                          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
                        ),
                      ],
                    ),
                    content: const Padding(
                      padding: EdgeInsets.all(8.0), // Apply padding around the content
                      child: Text('Are you sure you want to logout?'),
                    ),
                    actions: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center, // Center the text buttons horizontally
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Apply border radius
                              ),
                              elevation: 2.0, // Apply box shadow
                              side: const BorderSide(color: Colors.grey), // Apply border color
                              padding: const EdgeInsets.all(0), // Remove padding
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 35, 96, 18),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)), // Apply border radius
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                  minHeight: 45,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'NO',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(width: 10), // Add spacing between buttons

                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0), // Apply border radius
                              ),
                              elevation: 2.0, // Apply box shadow
                              side: const BorderSide(color: Colors.grey), // Apply border color
                              padding: const EdgeInsets.all(0), // Remove padding
                            ),
                            onPressed: () {
                              Navigator.pop(context); // Close the dialog
                              logout(context); // Call the logout function
                            },
                            child: Ink(
                              decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 35, 96, 18),
                                borderRadius: BorderRadius.all(Radius.circular(20.0)), // Apply border radius
                              ),
                              child: Container(
                                constraints: const BoxConstraints(
                                  minWidth: 100,
                                  minHeight: 45,
                                ),
                                alignment: Alignment.center,
                                child: const Text(
                                  'YES',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    Colors.white,
                    Color.fromARGB(255, 6, 184, 12),
                    Colors.yellow,
                  ],

                  center: Alignment.bottomCenter,
                  radius: 2.2,
                )
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _showLoading(); // Show loading indicator
                        final userProfile =
                        await MyApiService.getUserProfile(userId: widget.userId);
                        _hideLoading(); // Hide loading indicator
                        // Process the userProfile response
                        if (userProfile['success']) {
                          final userData = userProfile['data'];
                          // Update the UI or perform other necessary data handling
                          print('User Profile: $userData');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ProfilePage(userId: widget.userId), // Pass the userId to the ProfilePage
                            ),
                          );
                        } else {
                          final errorMessage = userProfile['message'];
                          // Handle the error message, you can show it to the user or take other necessary steps
                          print('Error: $errorMessage');
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        alignment: Alignment.topLeft,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 5,),
                                    Text(
                                      'Profile',
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green,
                                      ),
                                    ),
                                    SizedBox(height: 20,),
                                    Text(
                                      'View your Profile',
                                      style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.person,
                                color:Colors.green,
                                size: 40,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),
                    GestureDetector(
                      onTap: () {
                        _showLoading(); // Show loading indicator
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ),
                        );
                        _hideLoading(); // Hide loading indicator
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        alignment: Alignment.topLeft,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5,),
                                        Text(
                                          'Personnel Policies and Procedures',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "View 3 P's (Type 'Table of Contents')",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.message,
                                color: Colors.green,
                                size: 37,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    GestureDetector(
                      /* onTap: () {
                              _showLoading(); // Show loading indicator
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ChatScreen(),
                                ),
                              );
                              _hideLoading(); // Hide loading indicator
                            },*/
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(15, 2, 15, 2),
                        height: 70,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          ),
                        ),
                        alignment: Alignment.topLeft,
                        child: const Row(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 5,),
                                        Text(
                                          'Memorandums',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                          ),
                                        ),
                                        SizedBox(height: 20),
                                        Text(
                                          "Soon",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color:Colors.green,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.centerRight,
                              child: Icon(
                                Icons.book_online,
                                color: Colors.green,
                                size: 37,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
