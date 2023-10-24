import 'dart:convert';
import 'package:http/http.dart' as http;

class PasswordApi {
  final String baseUrl;

  PasswordApi(this.baseUrl);

  Future<String?> setPassword({
    required String uniqueId,
    required String password,
  }) async {
    final passwordData = {
      'id': uniqueId,
      'password': password,
    };

    final response = await http.post(
      Uri.parse('http://localhost:8080/api/v1/users/2'), // Adjust the URL as needed
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(passwordData),
    );

    if (response.statusCode == 200) {
      return 'Password set successfully';
    } else {
      // Handle the error and return an error message
      return 'Failed to set password: ${response.statusCode}';
    }
  }
}
