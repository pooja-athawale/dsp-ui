import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Import Provider


import '../models/login_page.dart';
import 'auth_provider.dart';

class AuthorizedPage extends StatefulWidget {
  @override
  _AuthorizedPageState createState() => _AuthorizedPageState();
}

class _AuthorizedPageState extends State<AuthorizedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Local Auth Demo"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Access the AuthProvider to call signOut
              Provider.of<AuthProvider>(context, listen: false).signOut();
            },
          ),
        ],
      ),

      body: Center(
        child: Text("YOU HAVE BEEN AUTHORIZED TO USE THE APP"),
      ),
    );
  }
}
