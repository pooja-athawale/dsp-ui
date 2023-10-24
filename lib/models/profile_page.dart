import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'new_login_page.dart';

class ProfilePage extends StatefulWidget {
  final String userId;

  ProfilePage({required this.userId});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  File? _image;

  void updateProfile() {
    // Add logic to update the user's profile here using the controllers' text.
  }

  Future<void> _getImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              print('Are you sure you want to Logout?');
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => NewLoginPage(userId: widget.userId),
                ),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Welcome, User ${widget.userId}!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Unique ID: ${widget.userId}',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Edit Profile'),
                      content: Column(
                        children: <Widget>[
                          TextField(

                            controller: firstNameController,
                            decoration: InputDecoration(labelText: 'First Name'),
                          ),
                          TextField(
                            controller: lastNameController,
                            decoration: InputDecoration(labelText: 'Last Name'),
                          ),
                          SizedBox(height: 20),
                          _image == null
                              ? Text('No image selected.')
                              : Image.file(_image!),
                          ElevatedButton(
                            onPressed: _getImage,
                            child: Text('Pick an image from gallery'),
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        ElevatedButton(
                          child: Text('Update'),
                          onPressed: () {
                            updateProfile();
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Text('Edit Profile'),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: 60,
              child: _image != null
                  ? Image.file(_image!, fit: BoxFit.cover)
                  : Image.network(
                'https://www.themoviedb.org/t/p/w300_and_h450_bestv2/8UusJIagRVST2FzfcJQYTjyIQUi.jpg',
                fit: BoxFit.cover,
              ),
            ),




          ],
        ),
      ),
    );
  }
}
