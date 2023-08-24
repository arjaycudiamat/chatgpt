import 'dart:convert';
import 'dart:io';
import 'package:chatgpt/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyApiService {
  static String user_id = '';

  static Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      String getServerBaseUrl() {
        if (Platform.isAndroid) {
          return 'http://10.0.2.2:8000'; // Android emulator
        } else if (Platform.isIOS) {
          return 'http://localhost:8000'; // iOS simulator
        }
        return '';
      } // Update the server endpoint based on your requirements
      final headers = {
        'Content-Type': 'application/json',
        // Update the correct origin of your app
      };
      final url = Uri.parse('${getServerBaseUrl()}/login');
      final body = jsonEncode({'email': email, 'password': password});

      print('Sending request to: $url');

      final response = await http.post(url, headers: headers, body: body);

      print('Response status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final userData = jsonDecode(response.body);
        user_id = userData['user_id'];

        return {'success': true, 'data': {...userData, 'user_id': user_id}};
      } else {
        final errorMessage = jsonDecode(response.body)['message'];
        return {'success': false, 'message': errorMessage};
      }
    }catch (e) {
      print('Exception: $e');
      return {'success': false, 'message': 'An error occured'};
    }
  }


  static Future<Map<String, dynamic>> getUserProfile({required String userId}) async {
    final url = Uri.parse('http://10.0.2.2:8000/users/$userId'); // Use the provided userId
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*', // Update the correct origin of your app
    };

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      final userProfileData = jsonDecode(response.body);
      return {'success': true, 'data': userProfileData};
    } else {
      final errorMessage = jsonDecode(response.body)['message'];
      return {'success': false, 'message': errorMessage};
    }
  }


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
    // Example: Using Navigator to push the login screen route and clear navigation history
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
          (Route<dynamic> route) => false, // Clear all existing routes in the navigation history
    );
  }

  static void displayLogoutSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Logout successful'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  static Future<void> updateUser({required String userId, required Map<String, dynamic> updatedData}) async {
    final url = Uri.parse('http://10.0.2.2:8000/updateusers/$userId'); // Update the server endpoint based on your requirements
    final headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*', // Update the correct origin of your app
    };
    final body = jsonEncode(updatedData);

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode != 200) {
      final errorMessage = jsonDecode(response.body)['message'];
      throw Exception('Failed to update user: $errorMessage');
    }
  }

  static void displayUpdateSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Update successful'),
        duration: Duration(seconds: 2),
      ),
    );
  }

}
