import 'package:dsp_ui/models/privacy_policy.dart';
import 'package:dsp_ui/models/profile_page.dart';
import 'package:dsp_ui/models/registration_page.dart';
import 'package:dsp_ui/models/set_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:uuid/uuid.dart';

class LoginPage extends StatefulWidget {


  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final uuid = Uuid();

  void _setPassword() {
    String userId = uuid.v4(); // Generate a unique user ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SetPasswordPage(userId: userId),
      ),
    );
  }

  void _registrationPage() {
    // Simulate sign-in logic here
    String userId = uuid.v4(); // Generate a unique user ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RegistrationPage(userId:''),
      ),
    );
  }
  void _profilePage() {
    // Simulate sign-in logic here
    String userId = uuid.v4(); // Generate a unique user ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfilePage(userId: userId),
      ),
    );
  }
  void _privacyPolicy() {
    // Simulate sign-in logic here
    String userId = uuid.v4(); // Generate a unique user ID
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PrivacyPolicy(),
      ),
    );
  }


  final LocalAuthentication authentication = LocalAuthentication();
  bool isAuthenticated = false;

  late final LocalAuthentication auth;
  bool _supportState = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _emailId;
  late String _password;

  final String _emailRegex = r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$';
  final String _passwordRegex = r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$';

  @override
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SizedBox(height: 20),
                Text(
                  'Sign in',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                TextFormField(
                  key: Key('keyEmailId'),
                  decoration: const InputDecoration(
                    labelText: 'EmailId',
                    prefixIcon: Icon(Icons.email ),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    if (!RegExp(_emailRegex).hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _emailId = value!;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  key: Key('keyPassword'),
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (!RegExp(_passwordRegex).hasMatch(value)) {
                      return 'Password must be at least 8 characters long and contain at least one letter and one number';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _password = value!;
                  },
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: _setPassword,
                  child: const Text('Forgot Password ?'),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _profilePage,
                  key: Key('keySignIn'),
                  child: const Text('Sign in'),
                ),
                const SizedBox(height: 16),
                TextButton(
                  onPressed:_registrationPage,
                  child: const Text('Not a member? Register here'),
                ),

                SizedBox(height: 16.0),

                ElevatedButton(
                  onPressed: () async {
                    // Check if biometrics are available
                    bool canCheckBiometrics =
                    await authentication.canCheckBiometrics;

                    if (canCheckBiometrics) {
                      // Authenticate with biometrics
                      bool authenticated = await authentication.authenticate(
                        localizedReason: 'Authenticate to access the app',
                      );

                      if (authenticated) {
                        // Biometric authentication successful
                        setState(() {
                          isAuthenticated = true;
                        });

                        // Navigate to the LoginPage upon successful authentication
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ProfilePage(userId: '',), // Replace 'LoginPage' with your actual page
                          ),
                        );
                      } else {
                        // Biometric authentication failed
                      }
                    } else {
                      // Biometrics not available on this device
                    }
                  },
                  child: Text('Authenticate with Biometrics'),
                ),

                TextButton(
                  onPressed:_privacyPolicy,
                  child: const Text('By tapping "Sign in", you agree to the DSP Terms of Service and acknowledge the DSP Privacy Policy.'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _signIn() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Perform registration logic with _email and _password
      print('Login successful: Email: $_emailId, Password: $_password');
    }
  }
}