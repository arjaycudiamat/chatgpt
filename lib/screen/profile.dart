import 'package:chatgpt/screen/updateprofile.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ProfilePage extends StatefulWidget {
  final String userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Map<String, dynamic> userProfile = {}; // Holds the user profile data
  String hoveredContainerId = '';
  bool hideContainer = true;

  @override
  void initState() {
    super.initState();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    final userId = widget.userId;
    final response =
    await http.get(Uri.parse('http://10.0.2.2:8000/users/$userId'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        userProfile = data['data'];
      });
    }
  }

  void handleUpdateProfile() async {
    final updatedProfile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => UpdateProfileScreen(
          userProfile: userProfile,
          userId: widget.userId,
        ),
      ),
    );

    if (updatedProfile != null) {
      // Extract the updated password from the updatedProfile map
      final updatedPassword = updatedProfile['password'];

      // Get the stored password from the user profile
      final storedPassword = userProfile['password'];

      // Validate the updated password against the stored password
      final isPasswordValid = (updatedPassword == storedPassword);

      if (isPasswordValid) {
        setState(() {
          userProfile = updatedProfile;
        });
      } else {
        // Display an error dialog or show an error message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Invalid Password'),
            content: const Text('The entered password is invalid.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }




  void handleContainerTap(String containerId) {
    // Handle container tap event
  }

  void handleMouseEnter(String containerId) {
    setState(() {
      hoveredContainerId = containerId;
    });
  }

  void handleMouseExit() {
    setState(() {
      hoveredContainerId = '';
    });
  }

  Widget buildContainer(
      {required String containerId,
        required String label,
        required String value}) {
    final isHovered = containerId == hoveredContainerId;

    return GestureDetector(
      onTap: () => handleContainerTap(containerId),
      child: MouseRegion(
        onEnter: (_) => handleMouseEnter(containerId),
        onExit: (_) => handleMouseExit(),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: isHovered ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 0.2, color: Colors.black),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 0,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              Text(
                '$label  ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isHovered ? Colors.green : Colors.black,
                ),
              ),
              Text(
                value,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.normal,
                  color: isHovered ? Colors.green : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), // Adjust the height as needed
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 184, 12),
          centerTitle: true,
          title: const Text('Profile'),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: handleUpdateProfile,
            ),
          ],
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Color.fromARGB(255, 6, 184, 12),
              Colors.yellow,
            ], // Specify the gradient colors
            center: Alignment.bottomCenter,
            radius: 2.2,
          ),
        ),
        child: Align(
            alignment: Alignment.topCenter,
            child: SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /*const SizedBox(height: 10),
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(
                      '${userProfile['profilePictureUrl']}',
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 3,
                        ),
                      ),
                    ),
                  ),*/
                  Visibility(
                    visible: !hideContainer,
                    child: buildContainer(
                      containerId: 'id',
                      label: 'ID:',
                      value: '${userProfile['id']}',
                    ),
                  ),
                  //const SizedBox(height: 10),
                  Visibility(
                    visible: !hideContainer,
                    child: buildContainer(
                      containerId: 'password',
                      label: 'Password:',
                      value: '${userProfile['password']}',
                    ),
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'institution',
                    label: 'Institution:',
                    value: '${userProfile['institution']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'department',
                    label: 'Department:',
                    value: '${userProfile['department']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'area',
                    label: 'Area:',
                    value: '${userProfile['area']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'unit',
                    label: 'Unit:',
                    value: '${userProfile['unit']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'staffid',
                    label: 'Staff ID:',
                    value: '${userProfile['staffid']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'name',
                    label: 'Name:',
                    value: '${userProfile['lname']}, ${userProfile['fname']} ${userProfile['mname']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'email',
                    label: 'Email:',
                    value: '${userProfile['email']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'uname',
                    label: 'Username:',
                    value: '${userProfile['uname']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'birthday',
                    label: 'Birthday:',
                    value: '${userProfile['birthday']}',
                  ),
                  const SizedBox(height: 10),
                  buildContainer(
                    containerId: 'age',
                    label: 'Age:',
                    value: '${userProfile['age']}',
                  ),


                ],
              ),
            ),
        ),
      ),
    );
  }
}
