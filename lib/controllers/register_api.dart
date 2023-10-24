import 'dart:convert';

import 'package:http/http.dart' as http;

class RegisterApi {
  final String baseUrl;

  RegisterApi(this.baseUrl);

  Future<String> registerUser({
    required String uniqueId,
    required String firstName,
    required String lastName,
    required String email,
    required String password, // Add the password parameter here
  }) async {
    final url = Uri.parse('$baseUrl/register');

    final body = jsonEncode({
      'id': uniqueId,
      'firstName': firstName,
      'lastName': lastName,
      'emailId': email,
      'password': password, // Pass the password to the API
    });

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: body,
    );

    if (response.statusCode == 200) {
      return 'User registered successfully';
    } else {
      return 'Error registering user: ${response.body}';
    }
  }
}
