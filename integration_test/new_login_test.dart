import 'package:dsp_ui/models/new_login_page.dart';
import 'package:dsp_ui/models/profile_page.dart';
import 'package:dsp_ui/models/registration_page.dart';
import 'package:dsp_ui/models/set_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Integration test for NewLoginPage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: NewLoginPage(userId: 'test_user_id'), // Replace 'test_user_id' with a valid user ID
    ));

    // Find widgets by their keys.
    final emailField = find.byKey(Key('keyEmailId'));
    final passwordField = find.byKey(Key('keyPassword'));
    final signInButton = find.byKey(Key('keySignIn'));
    final registerButton = find.text('Not a member? Register here');
    final forgotPasswordButton = find.text('Forgot Password ?');
    final biometricAuthButton = find.text('Authenticate with Biometrics');

    // Test Case 1: Successful Login
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'Password123');
    await tester.tap(signInButton);
    await tester.pump();
    expect(find.byType(ProfilePage), findsOneWidget);

    // Test Case 2: Validation Error (Empty Fields)
    await tester.enterText(emailField, ''); // Empty email
    await tester.enterText(passwordField, ''); // Empty password
    await tester.tap(signInButton);
    await tester.pump();
    expect(find.text('Please enter an email'), findsOneWidget); // Check for email validation error
    expect(find.text('Please enter a password'), findsOneWidget); // Check for password validation error

    // Test Case 3: Invalid Email Format
    await tester.enterText(emailField, 'invalid_email'); // Invalid email format
    await tester.enterText(passwordField, 'Password123');
    await tester.tap(signInButton);
    await tester.pump();
    expect(find.text('Please enter a valid email'), findsOneWidget); // Check for email format validation error

    // Test Case 4: Invalid Password Format
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'short'); // Short password
    await tester.tap(signInButton);
    await tester.pump();
    expect(find.text('Password must be at least 8 characters long and contain at least one letter and one number'), findsOneWidget); // Check for password format validation error

    // Test Case 5: Navigate to Registration Page
    await tester.tap(registerButton);
    await tester.pump();
    expect(find.byType(RegistrationPage), findsOneWidget);

    // Test Case 6: Navigate to Set Password Page
    await tester.tap(forgotPasswordButton);
    await tester.pump();
    expect(find.byType(SetPasswordPage), findsOneWidget);

    // Test Case 7: Simulate Biometric Authentication (Replace with your own test case)
    // Simulating biometric authentication can be challenging and may require additional dependencies or mocking libraries. This example assumes biometric authentication is available.
    await tester.tap(biometricAuthButton);
    await tester.pump();
    expect(find.byType(ProfilePage), findsOneWidget); // Assume biometric authentication is successful.

    // You can add more test cases based on your app's specific behavior and requirements.
  });
}
