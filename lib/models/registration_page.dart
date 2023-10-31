import 'package:dsp_ui/models/new_login_page.dart';
import 'package:dsp_ui/models/new_profile_page.dart';
import 'package:dsp_ui/models/privacy_policy.dart';
import 'package:dsp_ui/models/profile_page.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import '../controllers/register_api.dart';

class RegistrationPage extends StatefulWidget {
  final String userId;
  RegistrationPage({required this.userId, Key? key}) : super(key: key); // Add this constructor
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  //final registerApi = RegisterApi('http://localhost:8080');

   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _uniqueIdController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  late String _password; // Define _password variable
  late String _confirmPassword; // Define _confirmPassword variable
  final RegExp _passwordPattern = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
  );

  // Define the generateUniqueId() function here
  String generateUniqueId() {
    var uuid = Uuid();
    return uuid.v4(); // Generate a Version 4 (random) UUID

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Sign up',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _firstNameController,
                key: Key('keyFirstName'),
                decoration: const InputDecoration(labelText: 'First Name', border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your first name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _lastNameController,
                key: Key('keyLastName'),
                decoration: const InputDecoration(labelText: 'Last Name',border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your last name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _emailController,
                key: Key('keyEmailID'),
                decoration: const InputDecoration(labelText: 'Email ID',border: OutlineInputBorder()),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                      .hasMatch(value)) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                key: Key('keyPassword'),
                decoration: const InputDecoration(labelText: 'Password',border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a password';
                  }
                  if (!_passwordPattern.hasMatch(value)) {
                    return 'Password must be at least 8 characters long and contain at least one letter, one number, and one special character.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _password = value!; // Save the password value
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                key: Key('keyConfirmPassword'),
                decoration: const InputDecoration(labelText: 'Confirm Password',border: OutlineInputBorder()),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please confirm the password';
                  }
                  if (value != _password) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                onSaved: (value) {
                  _confirmPassword = value!; // Save the confirmation password value
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => NewLoginPage(userId: ''), // Pass the uniqueId
                    ),
                  );

                },
                child: const Text('Already a member? Login'),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context)=>NewProfilePage(
                      userId: widget.userId,
                      firstName: _firstNameController.text,
                      lastName: _lastNameController.text,
                    ),));

                },
                key: Key('keyContinue'),
                child: const Text('Continue'),
              ),
              SizedBox(height: 16.0),
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => PrivacyPolicy(), // Pass the uniqueId
                    ),
                  );

                },
                child: const Text('By tapping "Sign up", you agree to the DSP Terms of Service and acknowledge the DSP Privacy Policy.'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}