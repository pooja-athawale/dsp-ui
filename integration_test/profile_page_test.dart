import 'package:dsp_ui/models/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Integration test for ProfilePage', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: ProfilePage(userId: 'test_user_id'), // Replace 'test_user_id' with a valid user ID
    ));

    // Find widgets by their keys.
    final editProfileButton = find.text('Edit Profile');
    final updateButton = find.text('Update');
    final imagePickerButton = find.text('Pick an image from gallery');

    // Ensure the initial state of the image is the placeholder image.
    expect(find.byKey(Key('profilePlaceholderImage')), findsOneWidget);

    // Tap the "Edit Profile" button.
    await tester.tap(editProfileButton);
    await tester.pump();

    // Check if the update dialog is displayed.
    expect(find.text('Edit Profile'), findsOneWidget);
    expect(find.byType(TextField), findsNWidgets(2));

    // Fill in first name and last name.
    await tester.enterText(find.byKey(Key('firstNameController')), 'John');
    await tester.enterText(find.byKey(Key('lastNameController')), 'Doe');

    // Tap the image picker button (simulated image picking).
    await tester.tap(imagePickerButton);
    await tester.pump();

    // Ensure the update button is displayed.
    expect(updateButton, findsOneWidget);

    // Tap the "Update" button.
    await tester.tap(updateButton);
    await tester.pump();

    // Expect that the profile has been updated.
    expect(find.text('Welcome, User test_user_id!'), findsNothing);
    expect(find.text('Welcome, User John Doe!'), findsOneWidget);
  });
}
