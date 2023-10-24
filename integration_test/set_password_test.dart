import 'package:dsp_ui/models/profile_page.dart';
import 'package:dsp_ui/models/set_password_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SetPasswordPage Integration Tests', () {
    testWidgets('Valid Password Submission', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(
        home: SetPasswordPage(userId: 'test_user_id'),
      ));

      // Interact with the widget
      await tester.enterText(find.byKey(Key('keyPassword')), 'ValidPassword123@');
      await tester.enterText(find.byKey(Key('keyConfirmPassword')), 'ValidPassword123@');
      await tester.tap(find.byKey(Key('keySubmit')));

      // Wait for animations/transitions to complete
      await tester.pumpAndSettle();

      // Assert that the expected navigation occurs
      expect(find.byType(ProfilePage), findsOneWidget);
    });

    testWidgets('Invalid Password Submission', (WidgetTester tester) async {
      // Build the widget
      await tester.pumpWidget(MaterialApp(
        home: SetPasswordPage(userId: 'test_user_id'),
      ));

      // Interact with the widget
      await tester.enterText(find.byKey(Key('keyPassword')), 'InvalidPass');
      await tester.enterText(find.byKey(Key('keyConfirmPassword')), 'DifferentPass');
      await tester.tap(find.byKey(Key('keySubmit')));

          // Wait for animations/transitions to complete
          await tester.pumpAndSettle();

      // Assert that an error message is displayed
      expect(find.text('Passwords do not match'), findsOneWidget);
    });
  });
}
