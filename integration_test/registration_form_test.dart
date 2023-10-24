import 'package:dsp_ui/models/profile_page.dart';
import 'package:dsp_ui/models/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Integration test for RegistrationPage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: RegistrationPage(userId: 'test_user_id'), // Replace 'test_user_id' with a valid user ID
    ));

    // Find form fields and buttons by their keys.
    final firstNameField = find.byKey(Key('keyFirstName'));
    final lastNameField = find.byKey(Key('keyLastName'));
    final emailField = find.byKey(Key('keyEmailID'));
    final passwordField = find.byKey(Key('keyPassword'));
    final confirmPasswordField = find.byKey(Key('keyConfirmPassword'));
    final continueButton = find.byKey(Key('keyContinue'));

    // Enter valid data into form fields.
    await tester.enterText(firstNameField, 'John');
    await tester.enterText(lastNameField, 'Doe');
    await tester.enterText(emailField, 'john.doe@example.com');
    await tester.enterText(passwordField, 'Password123!');
    await tester.enterText(confirmPasswordField, 'Password123!');

    // Tap the Continue button.
    await tester.tap(continueButton);

    // Wait for the widgets to rebuild.
    await tester.pump();

    // Expect that the ProfilePage is navigated to after successful submission.
    expect(find.byType(ProfilePage), findsOneWidget);
  });
}
