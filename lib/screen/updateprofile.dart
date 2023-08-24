import 'package:chatgpt/services/apiservice.dart';
import 'package:flutter/material.dart';


class UpdateProfileScreen extends StatefulWidget {
  final Map<String, dynamic> userProfile;
  final String userId; // Add the userId parameter

  const UpdateProfileScreen({
    Key? key,
    required this.userProfile,
    required this.userId, // Include the userId parameter in the constructor
  }) : super(key: key);

  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  //File? _image;
  late TextEditingController _institutionController;
  late TextEditingController _departmentController;
  late TextEditingController _areaController;
  late TextEditingController _unitController;
  late TextEditingController _staffIdController;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _usernameController;
  late TextEditingController _birthdayController;
  late TextEditingController _ageController;
  late Map<String, dynamic> userProfile;
  final _formKey = GlobalKey<FormState>(); // Declare and initialize _formKey


  @override
  void initState() {
    super.initState();
    // Initialize the text controllers with the existing profile data
    userProfile = widget.userProfile;

    _institutionController =
        TextEditingController(text: userProfile['institution'] ?? '');
    _departmentController =
        TextEditingController(text: userProfile['department'] ?? '');
    _areaController = TextEditingController(text: userProfile['area'] ?? '');
    _unitController = TextEditingController(text: userProfile['unit'] ?? '');
    _staffIdController =
        TextEditingController(text: userProfile['staffid'] ?? '');
    _nameController = TextEditingController(
      text:
      '${userProfile['lname']}, ${userProfile['fname']} ${userProfile['mname']}',
    );
    _emailController = TextEditingController(text: userProfile['email'] ?? '');
    _usernameController =
        TextEditingController(text: userProfile['uname'] ?? '');
    _birthdayController =
        TextEditingController(text: userProfile['birthday'] ?? '');
    _ageController = TextEditingController(text: userProfile['age'] ?? '');
  }

  @override
  void dispose() {
    // Dispose the text controllers when the screen is disposed
    _institutionController.dispose();
    _departmentController.dispose();
    _areaController.dispose();
    _unitController.dispose();
    _staffIdController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _birthdayController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  /*Future _getImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }*/

  static void displayUpdateSuccessMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Update Successful'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void handleUpdateProfile(BuildContext context) async {
    // Retrieve the updated profile data from the text controllers
    final updatedProfile = <String, String>{};

    // Check each text field and add the changed fields to the updatedProfile map
    if (_institutionController.text.isNotEmpty &&
        _institutionController.text != widget.userProfile['institution']) {
      updatedProfile['institution'] = _institutionController.text;
    }

    if (_departmentController.text.isNotEmpty &&
        _departmentController.text != widget.userProfile['department']) {
      updatedProfile['department'] = _departmentController.text;
    }

    if (_areaController.text.isNotEmpty &&
        _areaController.text != widget.userProfile['area']) {
      updatedProfile['area'] = _areaController.text;
    }

    if (_unitController.text.isNotEmpty &&
        _unitController.text != widget.userProfile['unit']) {
      updatedProfile['unit'] = _unitController.text;
    }

    if (_staffIdController.text.isNotEmpty &&
        _staffIdController.text != widget.userProfile['area']) {
      updatedProfile['staffid'] = _staffIdController.text;
    }

    if (_nameController.text.isNotEmpty &&
        _nameController.text != widget.userProfile['name']) {
      updatedProfile['name'] = _nameController.text;
    }

    if (_emailController.text.isNotEmpty &&
        _emailController.text != widget.userProfile['email']) {
      updatedProfile['email'] = _emailController.text;
    }

    if (_usernameController.text.isNotEmpty &&
        _usernameController.text != widget.userProfile['uname']) {
      updatedProfile['uname'] = _usernameController.text;
    }

    if (_birthdayController.text.isNotEmpty &&
        _birthdayController.text != widget.userProfile['birthday']) {
      updatedProfile['birthday'] = _birthdayController.text;
    }

    if (_ageController.text.isNotEmpty &&
        _ageController.text != widget.userProfile['age']) {
      updatedProfile['age'] = _ageController.text;
    }

    try {
      // Get the user ID from the userProfile map
      final userId = widget.userProfile['id'];
      final userPassword = widget.userProfile['password'];

      showDialog(
        context: context,
        builder: (context) {
          String password = ''; // Variable to store the entered password

          return AlertDialog(
            title: const Text('Password Confirmation', textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Please input your Password.', textAlign: TextAlign.center),
                TextField(
                  onChanged: (value) {
                    password = value; // Update the password variable when the text changes
                  },
                  obscureText: true, // Hide the entered text
                  decoration: const InputDecoration(
                    labelText: 'Password',
                  ),
                ),
              ],
            ),
            actions: [
              Center(
                child: TextButton(
                  onPressed: () async {
                    // Compare the entered password with the stored password
                    if (password == userPassword) {
                      Navigator.pop(context); // Close the dialog
                      Navigator.pop(context); // Close the update profile screen

                      // Call the updateUser method from MyApiService to update the profile
                      await MyApiService.updateUser(
                        userId: userId,
                        updatedData: updatedProfile,
                      );

                      displayUpdateSuccessMessage(context);

                      Navigator.pop(context); // Close the update profile screen
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Invalid password'),
                          duration: Duration(seconds: 3),
                        ),
                      );
                    }
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 2, 115, 6), // Specify the desired button color
                  ),
                  child: const Text('OK', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          );
        },
      );
    } catch (error) {
      // Show an error dialog if updating the profile fails
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to update profile: $error'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50), // Adjust the height as needed
        child: AppBar(
          backgroundColor: const Color.fromARGB(255, 6, 184, 12),
          centerTitle: true,
          title: const Text('Profile Update'),
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
              ),
            ),
          ),
          SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              // Associate the GlobalKey<FormState> with the Form widget
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  /*GestureDetector(
                    onTap: _getImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: _image != null ? FileImage(_image!) : null,
                      child: _image == null
                          ? Icon(
                        Icons.camera_alt,
                        size: 60,
                        color: Colors.grey[300],
                      )
                          : null,
                      backgroundColor: Colors.grey[200],
                    ),
                  ),
                  const SizedBox(height: 20),*/
                  TextFormField(
                    controller: _institutionController,
                    decoration: const InputDecoration(
                      labelText: 'Institution',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _departmentController,
                    decoration: const InputDecoration(
                      labelText: 'Department',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _areaController,
                    decoration: const InputDecoration(
                      labelText: 'Area',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _unitController,
                    decoration: const InputDecoration(
                      labelText: 'Unit',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _staffIdController,
                    decoration: const InputDecoration(
                      labelText: 'Staff ID',
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    enabled: false,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _usernameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _birthdayController,
                    decoration: const InputDecoration(
                      labelText: 'Birthday',
                    ),
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    controller: _ageController,
                    decoration: const InputDecoration(
                      labelText: 'Age',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Ink(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: InkWell(
                      onTap: () => handleUpdateProfile(context),
                      borderRadius: BorderRadius.circular(12.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 27, 113, 26),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        child: const Center(
                          child: Text(
                            'SAVE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
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
        ],
      ),
    );
  }
}
