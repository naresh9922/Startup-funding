import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool _isEditing = false;

  @override
  void initState() {
    getPreferences();
    super.initState();
  }

  String _name = "";
  String _phone = "";
  String _address = "";
  String _email = "";
  String _class = "";
  String _experience = "";
  String _occupation = "";

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
    debugPrint("${userData!.length}");

    setState(() {
      _name = userData[0];
      _phone = userData[1];
      _email = userData[2];
      _class = userData[3];
      _address = userData[4];
    });
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() {
    // Save changes to the database (use Firebase or any other method)
    // Once saved, you might want to notify the user that changes are saved.
    // After saving, exit the edit mode.
    _toggleEditing();
  }
}
