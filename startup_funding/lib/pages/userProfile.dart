import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    getPreferences();
  }

  String _name = "";
  String _phone = "";
  String _address = "";
  String _email = "";
  String _class = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                // You can add an image here if available
              ),
              const SizedBox(height: 20),
              _isEditing
                  ? _buildEditableProfileInfo(
                      "Name:", _name, (value) => _name = value)
                  : _buildProfileInfo("Name:", _name),
              _isEditing
                  ? _buildEditableProfileInfo(
                      "Phone:", _phone, (value) => _phone = value)
                  : _buildProfileInfo("Phone:", _phone),
              _isEditing
                  ? _buildEditableProfileInfo(
                      "Email:", _email, (value) => _email = value)
                  : _buildProfileInfo("Email:", _email),
              _isEditing
                  ? _buildEditableProfileInfo(
                      "Class:", _class, (value) => _class = value)
                  : _buildProfileInfo("Class:", _class),
              _isEditing
                  ? _buildEditableProfileInfo(
                      "Address:", _address, (value) => _address = value)
                  : _buildProfileInfo("Address:", _address),
              if (_isEditing) SizedBox(height: 20),
              if (_isEditing)
                ElevatedButton(onPressed: _saveChanges, child: Text("Save")),
              if (!_isEditing) SizedBox(height: 20),
              ElevatedButton(
                  onPressed: _toggleEditing,
                  child: Text(_isEditing ? "Cancel" : "Edit")),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileInfo(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableProfileInfo(
      String title, String value, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(width: 25),
          Expanded(
            child: TextFormField(
              initialValue: value,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getPreferences() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String>? userData = _prefs.getStringList('userDetails');

    setState(() {
      _name = userData?[0] ?? "";
      _phone = userData?[1] ?? "";
      _email = userData?[2] ?? "";
      _class = userData?[3] ?? "";
      _address = userData?[4] ?? "";
    });
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    try {
      // Check if the email is not empty
      if (_email.isNotEmpty) {
        // Get the document reference using the email as the document ID
        DocumentReference userRef = firestore.collection('users').doc(_email);

        // Check if the document exists before updating
        DocumentSnapshot docSnapshot = await userRef.get();
        if (docSnapshot.exists) {
          // Update the document with new data
          await userRef.update({
            'name': _name,
            'phone': _phone,
            'class': _class,
            'address': _address,
          });

          // Notify the user that changes are saved (you can use a snackbar or any other UI element for this)

          _toggleEditing();
        } else {
          // Handle the case when the document doesn't exist
          print('Document with email $_email does not exist');
          // You can choose to create a new document instead of updating
          // or display an error message to the user
        }
      } else {
        // Handle the case when the email is empty
        print('Email is empty');
        // You can prompt the user to provide their email or handle it as needed
      }
    } catch (e) {
      // Handle errors, for example, show an error message to the user
      print('Error saving changes: $e');
    }
  }
}
