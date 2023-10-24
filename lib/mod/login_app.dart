import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:local_auth/local_auth.dart';

void main() {
  runApp(LoginApp());
}

class LoginApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login Form'),
        ),
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatelessWidget {
  final TextEditingController pinController = TextEditingController();
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<void> _authenticate() async {
    bool canCheckBiometrics = await _localAuthentication.canCheckBiometrics;
    if (canCheckBiometrics) {
      try {
        bool didAuthenticate = await _localAuthentication.authenticate(
          localizedReason: 'Authenticate to login',
        );

        if (didAuthenticate) {
          // Successfully authenticated with biometrics
          // Implement login logic here
        }
      } catch (e) {
        print('Authentication failed: $e');
        // Handle authentication errors here if needed
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            decoration: InputDecoration(labelText: 'Email/Mobile'),
          ),
          SizedBox(height: 20),
          TextFormField(
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Implement forgot password logic here
              },
              child: Text('Forgot Password?'),
            ),
          ),
          SizedBox(height: 20),
          PinCodeTextField(
            controller: pinController,
            appContext: context,
            length: 4, // Change the PIN length as needed
            obscureText: true,
            onChanged: (value) {
              // Handle PIN input
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement login logic here using PIN
            },
            child: Text('Login with MPIN'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _authenticate,
            child: Text('Fingerprint Login'),
          ),
          /*SizedBox(height: 20),
          Text('Or login with:'),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: () {
                  // Implement Google login logic here
                },
                icon: Icon(Icons.google),
                label: Text('Google'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement Facebook login logic here
                },
                icon: Icon(Icons.facebook),
                label: Text('Facebook'),
              ),
              SizedBox(width: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Implement LinkedIn login logic here
                },
                icon: Icon(Icons.linkedin),
                label: Text('LinkedIn'),
              ),
            ],
          ),*/
        ],
      ),
    );
  }
}
