import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Add this import statement
import 'register_page.dart';
import 'user_panel.dart'; // Import the UserPanel class/file
import 'admin_panel.dart'; // Import the AdminPanel class/file
import 'database_helper.dart';

class LoginPage extends StatefulWidget {
  final String? mobileNumber;
  final String? password;
  const LoginPage({Key? key, this.mobileNumber, this.password})
      : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isMobileFocused = false;
  bool _isPasswordFocused = false;
  String? _selectedRole;

  // Inside your _LoginPageState class where you want to authenticate the user or admin

  Future<void> _authenticate() async {
    String mobileNumber = _mobileController.text;
    String password = _passwordController.text;
    if (_selectedRole == 'User') {
      bool isAuthenticated = await DatabaseHelper.instance
          .authenticateUser(mobileNumber, password);
      if (isAuthenticated) {
        // Navigate to UserPanel or perform any action for successful authentication
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => UserPanel()),
        );
      } else {
        // Handle unsuccessful authentication for user
        // For example, show a snackbar with an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Authentication failed. Please check your credentials.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } else if (_selectedRole == 'Admin') {
      bool isAuthenticated = await DatabaseHelper.instance
          .authenticateAdmin(mobileNumber, password);
      if (isAuthenticated) {
        // Navigate to AdminPanel or perform any action for successful authentication
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AdminPanel()),
        );
      } else {
        // Handle unsuccessful authentication for admin
        // For example, show a snackbar with an error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content:
                Text('Authentication failed. Please check your credentials.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  void initState() {
    super.initState();
    // Pre-fill the fields with passed values
    _mobileController.text = widget.mobileNumber ?? '';
    _passwordController.text = widget.password ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          Colors.transparent, // Set background color to transparent
      body: Container(
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              const Text(
                "Sign In",
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
                          child: DropdownButtonFormField<String>(
                            value: _selectedRole,
                            hint: const Text(
                              'Select Role',
                              style: TextStyle(
                                color: Colors
                                    .white, // Set hint text color to white
                              ),
                            ),
                            items: ['Admin', 'User'].map((String role) {
                              return DropdownMenuItem<String>(
                                value: role,
                                child: Text(
                                  role,
                                  style: const TextStyle(
                                    color:
                                        Colors.white, // Set text color to white
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedRole = value;
                              });
                            },
                            decoration: InputDecoration(
                              labelText: 'Role',
                              labelStyle: const TextStyle(color: Colors.white),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white, // Border color
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white, // Border color
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon:
                                  const Icon(Icons.person, color: Colors.white),
                            ),
                            style: const TextStyle(
                                color: Colors
                                    .white), // Set button text color to white
                            elevation: 2, // Set elevation to 2
                            iconEnabledColor: Colors
                                .lightBlue, // Set icon color when enabled to light blue
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select a role';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
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
                              labelStyle: const TextStyle(
                                  color: Colors.white), // Text color
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white, // Border color
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white, // Border color
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: !_isMobileFocused
                                  ? const Icon(Icons.phone, color: Colors.white)
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
                        const SizedBox(height: 20.0),
                        SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(
                                  color: Colors.white), // Text color
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white, // Border color
                                  width: 2.0,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: const BorderSide(
                                  color: Colors.white, // Border color
                                  width: 2.0,
                                ),
                              ),
                              prefixIcon: !_isPasswordFocused
                                  ? const Icon(Icons.lock, color: Colors.white)
                                  : null,
                              suffixIcon: !_isPasswordFocused
                                  ? const Icon(Icons.visibility,
                                      color: Colors.white)
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
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Row(
                          children: [
                            Checkbox(
                              value: _rememberMe,
                              onChanged: (value) {
                                setState(() {
                                  _rememberMe = value ?? false;
                                });
                              },
                              checkColor: Colors.white,
                              fillColor: MaterialStateProperty.resolveWith(
                                  (states) => Colors.yellow),
                            ),
                            const Text(
                              'Remember Me',
                              style: TextStyle(color: Colors.white),
                            ),
                            const Spacer(),
                            TextButton(
                              onPressed: () {
                                // Add logic for forgot password
                              },
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20.0),
                        ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              _authenticate();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 120, vertical: 20),
                            backgroundColor: Colors.blue,
                          ),
                          child: const Text('Login',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'OR',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Sign in with',
                          style: TextStyle(color: Colors.white),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              onPressed: () {
                                // Add logic for Facebook sign-in
                              },
                              icon: Image.asset(
                                  'assets/images/facebook_icon.png',
                                  width: 40,
                                  height: 40), // Facebook icon image
                            ),
                            IconButton(
                              onPressed: () {
                                // Add logic for Google sign-in
                              },
                              icon: Image.asset('assets/images/google_icon.png',
                                  width: 35, height: 35), // Google icon image
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const SignupPage()), // Assuming RegisterPage is the name of your registration page
                            );
                          },
                          child: const Text(
                            "Don't have an account? Sign Up",
                            style: TextStyle(color: Colors.white),
                          ),
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
