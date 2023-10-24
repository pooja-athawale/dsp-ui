import 'package:dsp_ui/models/profile_page.dart';
import 'package:flutter/material.dart';

import '../controllers/password_api.dart';

class SetPasswordPage extends StatefulWidget {
  final String userId;

  SetPasswordPage({required this.userId});

  @override
  _SetPasswordPageState createState() => _SetPasswordPageState();
}

class _SetPasswordPageState extends State<SetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  late String _password; // Define _password variable
  late String _confirmPassword; // Define _confirmPassword variable
  final PasswordApi passwordApi = PasswordApi('http://localhost:8080'); // Replace with your API base URL


  final RegExp _passwordPattern = RegExp(
    r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$',
  );

  @override
  Widget build(BuildContext context) {
    String userId = widget.userId;

    return Scaffold(
      appBar: AppBar(title: Text('Set Password')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                key: Key('keyPassword'),
                decoration: const InputDecoration(labelText: 'Password'),
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
                decoration: const InputDecoration(labelText: 'Confirm Password'),
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
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                 print('Submit button tapped');

                if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();

                // Ensure that _confirmPassword is updated before the comparison
                   final String confirmPassword = _confirmPassword;

                if (_password == confirmPassword) {
              // Passwords match, proceed to set the password
                final result = await passwordApi.setPassword(
                uniqueId: widget.userId,
                password: _password,
              );

                if (result == 'Password set successfully') {
              // Password set successfully, navigate to the next screen
                  try {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(userId: userId),
                      ),
                    );
                  } catch (e) {
                    print('Navigation error: $e');
                  }

                } else  {
              // Handle the error, display a message, or log it
                print(result);
              }
              } else {
              // Handle the case where passwords do not match
                print('Passwords do not match');
               }
              }
          },
              key: Key('keySubmit'),
                 child: Text('Submit'),
               ),
            ],
          ),
        ),
      ),
    );
  }
}
