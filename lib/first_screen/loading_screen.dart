import 'package:dsp_ui/models/login_page.dart';
import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  //LocalAuthentication authentication = LocalAuthentication();
  final LocalAuthentication authentication = LocalAuthentication();
  bool isAuthenticated = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "LOADING...",
              style: TextStyle(
                  letterSpacing: 5, fontSize: 20, fontWeight: FontWeight.w600),
            ),

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
                    /* Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => LoginPage(
                          userId: '',
                        ), // Replace 'LoginPage' with your actual page
                      ),
                    );*/
                  } else {
                    // Biometric authentication failed
                  }
                } else {
                  // Biometrics not available on this device
                }
              },
              child: Text('Authenticate with Biometrics'),
            ),

            // Display app content based on authentication status...
          ],
        ),
      ),
    );
  }
}
