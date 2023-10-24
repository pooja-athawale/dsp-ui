import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
// Create a TextEditingController for the email input field

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

Future<void> sendEmail(String recipient, String subject, String body) async {
  final smtpServer = gmail('your.email@gmail.com', 'your_password'); // Replace with your email and password

  final message = Message()
    ..from = Address('your.email@gmail.com') // Replace with your email

    ..recipients.add(recipient)
    ..subject = subject
    ..text = body;

  try {
    final sendReport = await send(message, smtpServer);
    print('Message sent successfully.');
  } catch (e) {
    print('Message not sent. Error: $e');
  }
}


final emailController = TextEditingController();

// Step 2: Create the UI for the "Forgot Password" feature
class ForgotPasswordPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
            ),
            ElevatedButton(
              onPressed: () {
                // Step 3: Validate the email address
                final email = emailController.text;
                if (isValidEmail(email)) {
                  // Step 4: Generate a unique token
                  final resetToken = generateUniqueToken();
                  // Step 5: Send the reset email
                  sendResetEmail(email, resetToken);
                } else {
                  // Handle invalid email
                }
              },
              child: Text("Reset Password"),
            ),
          ],
        ),
      ),
    );
  }
}

bool isValidEmail(String email) {
  // Regular expression for a valid email address
  final emailRegExp = RegExp(
    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$',
    caseSensitive: false,
  );

  return emailRegExp.hasMatch(email);
}

String generateUniqueToken() {
  final random = Random.secure();
  final List<int> bytes = List.generate(32, (index) => random.nextInt(256));
  final token = base64Url.encode(bytes);
  return token;
}

void sendResetEmail(String email, String resetToken) {
  // Step 5: Implement sending the email using your chosen email service
  // You need to configure and use your email service provider here.
  // This example uses a hypothetical `sendEmail` function.
  sendEmail(
    email,
    "Password Reset",
    "Click the link to reset your password: example.com/reset?token=$resetToken",
  );
}
