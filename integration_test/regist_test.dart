import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:dsp_ui/models/registration_page.dart'; // Replace with the actual import for your registration page.

void main() {
  testWidgets(
      'Registration Page Integration Test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MaterialApp(
        home: RegistrationPage(
            userId: 'testUniqueId'), // Provide a uniqueId for testing
      ),
    );

    // Enter text into the First Name field
    await tester.enterText(find.byKey(Key('keyFirstName')), 'John');
    await tester.pump(Duration(seconds: 5));

    // Enter text into the Last Name field
    await tester.enterText(find.byKey(Key('keyLastName')), 'Doe');
    await tester.pump(Duration(seconds: 5));

    // Enter text into the Email ID field
    await tester.enterText(
        find.byKey(Key('keyEmailID')), 'johndoe@example.com');
    await tester.pump(Duration(seconds: 5));

    // Enter text into the Password field
    await tester.enterText(find.byKey(Key('keyPassword')), 'password123!');
    await tester.pump(Duration(seconds: 5));

    // Enter text into the Confirm Password field
    await tester.enterText(
        find.byKey(Key('keyConfirmPassword')), 'password123!');
    await tester.pump(Duration(seconds: 5));

    // Tap the "Continue" button
    await tester.tap(find.widgetWithText(ElevatedButton, 'Continue'));

    // Wait for the UI to update
    await tester.pump(Duration(seconds: 10));

    // Add your assertions to verify the expected behavior, e.g., navigation to a new page
    expect(find.byKey(Key('keyNewLoginPage')), findsOneWidget);
  });
}




