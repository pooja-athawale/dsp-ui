import 'package:dsp_ui/models/mobile_verification.dart';
import 'package:dsp_ui/models/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Integration test for MobileVerification', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: MobileVerification(),
    ));

    // Find widgets by their keys.
    final sendOtpButton = find.text('Send OTP');
    final otpInputField = find.byType(TextField);
    final verifyOtpButton = find.text('Verify OTP');

    // Test Case 1: Send OTP
    await tester.tap(sendOtpButton);
    await tester.pump();
    // Expect that the timer is started, you can also check the timer label
    expect(find.text(' seconds remaining'), findsOneWidget);

    // Test Case 2: Verify OTP (Successful)
    // Simulate OTP entry (replace with your actual OTP)
    await tester.enterText(otpInputField, '1234'); // Replace '1234' with the actual OTP
    await tester.tap(verifyOtpButton);
    await tester.pump();
    // Expect that the app navigates to the RegistrationPage upon successful OTP verification
    expect(find.byType(RegistrationPage), findsOneWidget);

    // Test Case 3: Verify OTP (Failed)
    // Simulate an incorrect OTP (replace with an incorrect OTP)
    await tester.enterText(otpInputField, '5678'); // Replace '5678' with an incorrect OTP
    await tester.tap(verifyOtpButton);
    await tester.pump();
    // Expect that the app displays a message or behavior indicating OTP verification failure

    // You can add more test cases based on your app's specific behavior and requirements.
  });
}
