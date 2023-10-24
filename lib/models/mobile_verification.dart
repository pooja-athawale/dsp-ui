import 'dart:async';
import 'package:dsp_ui/models/registration_page.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/phone_number.dart';

class MobileVerification extends StatefulWidget {
  @override
  _MobileVerificationState createState() => _MobileVerificationState();
}

class _MobileVerificationState extends State<MobileVerification> {

  int _remainingTime = 45;
  Timer? _timer;
  String _phoneNumber = '';
  String _generatedOtp = '';
  TextEditingController _otpController = TextEditingController();

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_remainingTime > 0) {
          _remainingTime--;
        } else {
          _timer?.cancel();
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
  void _sendOtp() {
    // Generate a random 4-digit OTP
    _generatedOtp = (1000 + DateTime.now().millisecondsSinceEpoch % 9000).toString();
    print('Generated OTP: $_generatedOtp');
  }

  void _verifyOtp() {
    String enteredOtp = _otpController.text;
    if (enteredOtp == _generatedOtp) {
      print('OTP verification successful');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RegistrationPage(userId: '',)),);

    } else {
      print('OTP verification failed');
    }
  }

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
                  'Phone Verification',
                   style: TextStyle(
                   fontSize: 24,
                   fontWeight: FontWeight.bold,
                  ),
                ),
              SizedBox(height: 20),
                Text(
                  'Add a phone number to further secure your account. We will text you a code',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(color: Colors.grey),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: InputBorder.none,
                    ),
                    onChanged: (PhoneNumber phoneNumber) {
                      setState(() {
                        _phoneNumber = phoneNumber.completeNumber;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
                Text(
                  'Your number will not be shared with others. Message and data rates may apply',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: () {
                  _sendOtp();
                  _startTimer(); // Start the countdown timer
                },
                child: Text('Send OTP'),
              ),

              SizedBox(height: 20),
              TextField(
                controller: _otpController,
                keyboardType: TextInputType.number,
                maxLength: 4, // Limit input to 4 characters
                decoration: InputDecoration(
                  labelText: 'Enter OTP',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                '$_remainingTime seconds remaining',
                style: TextStyle(
                  color: _remainingTime > 0 ? Colors.grey : Colors.red,
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyOtp,
                child: Text('Verify OTP'),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
