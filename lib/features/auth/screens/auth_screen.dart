import 'package:flutter/material.dart';
import 'package:my_app/common/widgets/custom_button.dart';
import 'package:my_app/common/widgets/custom_textfield.dart';
import 'package:my_app/global_variables.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'items_screen.dart';


enum Auth { signin, signup }

class AuthScreen extends StatefulWidget {
  static const String routeName = "auth-screen";

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  Auth _auth = Auth.signup;
  final _signupFormKey = GlobalKey<FormState>();
  final _signinFormKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  String _errorMessage = '';
  
  get convert => null;

  bool isValidEmail(String email) {
    final emailRegExp = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zAZ]{2,}))$',
    );
    return emailRegExp.hasMatch(email);
  }


Future<bool> emailExists(String email) async {
  // Create a new HTTP request
  final request = http.Request('GET', Uri.parse('http://localhost:3000/api/users/$email'));

  // Set the request headers
  request.headers['Accept'] = 'application/json';

  // Send the request and get the response
  final response = await request.send();

  // Check if the response is successful
  if (response.statusCode == 200) {
    // The email ID exists
    return true;
  } else {
    // The email ID does not exist
    return false;
  }
}
bool isPasswordValid(String password) {
  return password.length >= 6;
}

Future<bool> signupDetailsMatch(String name, String email, String password) async {
    // Create a new HTTP request
    final request = http.Request('POST', Uri.parse('http://localhost:3000/api/signup'));

    // Set the request headers
    request.headers['Content-Type'] = 'application/json';

    // Set the request body
    final body = {
      'name': name,
      'email': email,
      'password': password,
    };

    // Encode the request body as JSON
    request.body = jsonEncode(body);

    // Send the request and get the response
    final response = await request.send();

    // Check if the response is successful
    if (response.statusCode == 200) {
      // The signup details match
      return true;
    } else {
      // The signup details do not match
      return false;
    }
  }

Future<bool> loginDetailsMatch(String email, String password) async {
  // Create a new HTTP request
  final request = http.Request('GET', Uri.parse('http://localhost:3000/api/login'));

  // Set the request headers
  request.headers['Content-Type'] = 'application/json';

  // Set the request body
  final body = {
    'email': email,
    'password': password,
  };

  // Encode the request body as JSON
  request.body = jsonEncode(body);

  // Send the request and get the response
  final response = await request.send();

  // Check if the response is successful
  if (response.statusCode == 200) {
    // The login details match
    return true;
  } else {
    // The login details do not match
    return false;
  }
}


  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
  }

  void clearErrorMessage() {
    setState(() {
      _errorMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const Text(
                "UniCart",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              ListTile(
                title: const Text(
                  "Create Account",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: const Color.fromARGB(255, 0, 174, 255),
                  value: Auth.signup,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signup)
                Form(
                  key: _signupFormKey,
                  child: Column(
                    children: [
                      CustomTextfield(
                        controller: _nameController,
                        hintText: "Name",
                      ),
                      const SizedBox(height: 10),
                      CustomTextfield(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(height: 10),
                      CustomTextfield(
                        controller: _passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: "Sign Up",
                        onTap: () async {
                          clearErrorMessage(); // Clear previous error message
                          if (!isValidEmail(_emailController.text)) {
                            _errorMessage = "Please Enter a Valid email address";
                          }
                          if (await emailExists(_emailController.text)) {
                            _errorMessage = "Email address already exists";
                             return;
                          }
                          if (!isPasswordValid (_passwordController.text)){
                            _errorMessage = 'Password must be at least 6 characters long';
                          }

                          else {// Save the signup details if there are no errors
                          await signupDetailsMatch(_nameController.text, _emailController.text, _passwordController.text);
                           }
                        },
                      ),
                    ],
                  ),
                ),
              ListTile(
                title: const Text(
                  "Sign-In",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Radio(
                  activeColor: const Color.fromARGB(255, 0, 174, 255),
                  value: Auth.signin,
                  groupValue: _auth,
                  onChanged: (Auth? val) {
                    setState(() {
                      _auth = val!;
                    });
                  },
                ),
              ),
              if (_auth == Auth.signin)
                Form(
                  key: _signinFormKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 10),
                      CustomTextfield(
                        controller: _emailController,
                        hintText: "Email",
                      ),
                      const SizedBox(height: 10),
                      CustomTextfield(
                        controller: _passwordController,
                        hintText: "Password",
                      ),
                      const SizedBox(height: 10),
                      CustomButton(
                        text: "Sign In",
                        onTap: () async {
                        // Clear previous error message
                        clearErrorMessage();
                        final bool loginSuccessful = await loginDetailsMatch(_emailController.text, _passwordController.text);
                        // If the login is successful, navigate to the next screen           
                        if (loginSuccessful) {
                        Navigator.pushNamed(context, '/items_screen');
                        }  else {
                        // If the login is not successful, show an error message
                        _errorMessage = "Invalid email or password";
                        }
                        },
                      ),
                    ],
                  ),
                ),
              // Error message
              if (_errorMessage.isNotEmpty)
                Text(
                  _errorMessage,
                  style: const TextStyle(
                    color: Colors.red,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
