// ignore: file_names
// ignore: file_names
import 'package:flutter/material.dart'
    show AlertDialog, Alignment, BorderRadius, BorderSide, BoxDecoration, BuildContext, Colors, Column, Container, CrossAxisAlignment, EdgeInsets, ElevatedButton, Expanded, FocusNode, FontWeight, Form, FormState, GlobalKey, Icon, IconButton, Icons, InputDecoration, Key, LinearGradient, MainAxisAlignment, MediaQuery, Navigator, OutlineInputBorder, Padding, Radius, Scaffold, SingleChildScrollView, SizedBox, State, StatefulWidget, Text, TextAlign, TextButton, TextEditingController, TextFormField, TextInputType, TextStyle, Widget, showDialog;
import 'package:flutter/services.dart';

import 'database_helper.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController =
  TextEditingController(); // New controller for full name
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isMobileFocused = false;
  bool _isPasswordFocused = false;
  bool _isPasswordVisible = false;
  bool _isEmailFocused = false;
  bool _isFullNameFocused = false; // New boolean for full name focus

  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final FocusNode _fullNameFocusNode =
  FocusNode(); // New focus node for full name

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    _fullNameFocusNode.dispose(); // Dispose the full name focus node
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body:Container(
        decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
        Color(0xFFEEA2A2),
    Color(0xFFBBC1BF),
    Color(0xFF57C6E1),
    Color(0xFFB49FDA),
    Color(0xFF7AC5D8),
    ],
    stops: [0.0, 0.19, 0.42, 0.79, 1.0],
    ),
    ),
      child:Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Sign Up",
              style: TextStyle(
                fontFamily: 'poppins',
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Expanded(
              child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _fullNameController,
                            decoration: InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: !_isFullNameFocused
                                  ? Icon(Icons.person, color: Colors.white)
                                  : null,
                            ),
                            onTap: () {
                              setState(() {
                                _isFullNameFocused = true;
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                _isFullNameFocused = false;
                              });
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your full name';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _mobileController,
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                              LengthLimitingTextInputFormatter(11),
                            ],
                            decoration: InputDecoration(
                              labelText: 'Mobile Number',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: !_isMobileFocused
                                  ? Icon(Icons.phone, color: Colors.white)
                                  : null,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              } else if (value.length != 11) {
                                return 'Mobile number must be 11 digits';
                              }
                              return null;
                            },
                            onTap: () {
                              setState(() {
                                _isMobileFocused = true;
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                _isMobileFocused = false;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _emailController,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: !_isEmailFocused
                                  ? Icon(Icons.email, color: Colors.white)
                                  : null,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }
                              return null;
                            },
                            onTap: () {
                              setState(() {
                                _isEmailFocused = true;
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                _isEmailFocused = false;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: !_isPasswordVisible,
                            focusNode: _passwordFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: !_isPasswordFocused
                                  ? Icon(Icons.lock, color: Colors.white)
                                  : null,
                              suffixIcon: !_isPasswordFocused
                                  ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible =
                                    !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              )
                                  : null,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            onTap: () {
                              setState(() {
                                _isPasswordFocused = true;
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                _isPasswordFocused = false;
                                _confirmPasswordFocusNode.requestFocus();
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 20.0),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: !_isPasswordVisible,
                            focusNode: _confirmPasswordFocusNode,
                            decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: !_isPasswordFocused
                                  ? Icon(Icons.lock, color: Colors.white)
                                  : null,
                              suffixIcon: !_isPasswordFocused
                                  ? IconButton(
                                onPressed: () {
                                  setState(() {
                                    _isPasswordVisible =
                                    !_isPasswordVisible;
                                  });
                                },
                                icon: Icon(
                                  _isPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              )
                                  : null,
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != _passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            onTap: () {
                              setState(() {
                                _isPasswordFocused = true;
                              });
                            },
                            onEditingComplete: () {
                              setState(() {
                                _isPasswordFocused = false;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 40.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              String mobileNumber = _mobileController.text;
                              String password = _passwordController.text;
                              String confirmPassword =
                                  _confirmPasswordController.text;
                              String email = _emailController.text;
                              String fullName = _fullNameController.text;
                              try {
                                int id =
                                await DatabaseHelper.instance.insertUser({
                                  DatabaseHelper.columnFullName: fullName,
                                  DatabaseHelper.columnMobile: mobileNumber,
                                  DatabaseHelper.columnEmail: email,
                                  DatabaseHelper.columnPassword: password,
                                });
                                // Registration successful
                                print('Registration successful. User ID: $id');
                              } catch (e) {
                                // Registration failed
                                print('Error during registration: $e');
                                // Display error message to the user
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Registration Failed'),
                                      content: const Text(
                                          'An error occurred during registration. Please try again.'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 120, vertical: 20),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Register',
                              style:
                              TextStyle(color: Colors.white, fontSize: 18)),
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
    );
  }
}
