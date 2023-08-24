import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../header/popup_menu.dart';
import '../screen/login.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _staffIdController = TextEditingController();
  final TextEditingController _fnameController = TextEditingController();
  final TextEditingController _mnameController = TextEditingController();
  final TextEditingController _lnameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _unameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _cpasswordController = TextEditingController();

  Future<void> _registerUser() async {
    if (_formKey.currentState!.validate()) {
      // Validate form fields
      String institution = _institutionController.text;
      String department = _departmentController.text;
      String area = _areaController.text;
      String unit = _unitController.text;
      String staffId = _staffIdController.text;
      String fname = _fnameController.text;
      String mname = _mnameController.text;
      String lname = _lnameController.text;
      String birthday = _birthdayController.text;
      String age = _ageController.text;
      String email = _emailController.text;
      String uname = _unameController.text;
      String password = _passwordController.text;
      String cpassword = _cpasswordController.text;

      // Send registration request to the server
      var url = Uri.parse('http://10.0.2.2:8000/newuser');
      var response = await http.post(url, body: {
        'institution': institution,
        'department': department,
        'area': area,
        'unit': unit,
        'staffId': staffId,
        'fname': fname,
        'mname': mname,
        'lname': lname,
        'birthday': birthday,
        'age': age,
        'email': email,
        'uname': uname,
        'password': password,
        'cpassword': cpassword,
      });

      if (response.statusCode == 201) {
        // Registration successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Registration successful')),
        );
      } else if (response.statusCode == 500) {
        // Email already registered
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Email or Staff ID is already registered')),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        _birthdayController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Navigate to the index page when the back button is pressed
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const LoginScreen()),
          );
          return false; // Return false to prevent default back button behavior
        },
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50), // Adjust the height as needed
            child: AppBar(
              backgroundColor: const Color.fromARGB(255, 6, 184, 12),
              centerTitle: true,
              title: const Text('Personal Information'),
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
          body: Stack(
            children: [
              Container(
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    colors: [
                      Colors.white,
                      Color.fromARGB(255, 6, 184, 12)
                    ],
                    center: Alignment.bottomCenter,
                    radius: 1,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _institutionController,
                          decoration: const InputDecoration(labelText: 'Institution'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your institution';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _departmentController,
                          decoration: const InputDecoration(labelText: 'Department'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your department';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _areaController,
                          decoration: const InputDecoration(labelText: 'Area'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your area';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _unitController,
                          decoration: const InputDecoration(labelText: 'Unit'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your unit';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _staffIdController,
                          decoration: const InputDecoration(labelText: 'Staff ID'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your staff ID';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _fnameController,
                          decoration: const InputDecoration(labelText: 'First Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your first name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _mnameController,
                          decoration: const InputDecoration(labelText: 'Middle Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your middle name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _lnameController,
                          decoration: const InputDecoration(labelText: 'Last Name'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your last name';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _birthdayController,
                          decoration: const InputDecoration(
                            labelText: 'Birthday',
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () => _selectDate(context),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your birthday';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: 'Age'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your age';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }

                            if (!RegExp(r'^.+@cardmri\.com$').hasMatch(value)) {
                              return 'Please enter a valid cardmri email address';
                            }

                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _unameController,
                          decoration: const InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your username';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        TextFormField(
                          controller: _cpasswordController,
                          decoration: const InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != _passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 30.0),
                        InkWell(
                          onTap: _registerUser,
                          borderRadius: BorderRadius.circular(12.0),
                          child: Material(
                            borderRadius: BorderRadius.circular(12.0),
                            color: const Color.fromARGB(255, 27, 113, 26),
                            child: InkWell(
                              onTap: _registerUser,
                              borderRadius: BorderRadius.circular(12.0),
                              child: Container(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: const Center(
                                  child: Text(
                                    'Register',
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
                        ),
                        const SizedBox(height: 18.0),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const LoginScreen()),
                            );
                          },
                          child: Center(
                            child: RichText(
                              text: TextSpan(
                                text: 'Already have an account? Click here to ',
                                style: const TextStyle(color: Colors.black),
                                children: [
                                  TextSpan(
                                    text: 'Login',
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.yellow,
                                      decoration: TextDecoration.none,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                                        );
                                      },
                                  ),
                                ],
                              ),
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
        )
    );
  }
}
