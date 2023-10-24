import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  bool isAuthenticated = false;

  // Add methods to handle authentication and sign-out here
  // ...

  void signOut() {
    isAuthenticated = false;
    // Perform any other sign-out related logic
    // ...

    // Notify listeners that the authentication state has changed
    notifyListeners();
  }
}