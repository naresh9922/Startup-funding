import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  String _role = "";
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
              const CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/profile.jpeg'),
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
                  ? Visibility(
                      visible: _role == 'Investor' || _role == 'Student',
                      child: _buildEditableProfileInfo(
                          "Address:", _address, (value) => _address = value),
                    )
                  : Visibility(
                      visible: _role == 'Investor' || _role == 'Student',
                      child: _buildProfileInfo("Address:", _address),
                    ),
              _isEditing
                  ? Visibility(
                      visible: _role == 'Student',
                      child: _buildEditableProfileInfo(
                          "Class:", _class, (value) => _class = value),
                    )
                  : Visibility(
                      visible: _role == 'Student',
                      child: _buildProfileInfo("Class:", _class),
                    ),
              _isEditing
                  ? Visibility(
                      visible: _role == 'Investor',
                      child: _buildEditableProfileInfo("Occupation:",
                          _occupation, (value) => _occupation = value),
                    )
                  : Visibility(
                      visible: _role == 'Investor',
                      child: _buildProfileInfo("Occupation :", _occupation),
                    ),
              _isEditing
                  ? Visibility(
                      visible: _role == 'Investor',
                      child: _buildEditableProfileInfo("Experience:",
                          _experience, (value) => _experience = value),
                    )
                  : Visibility(
                      visible: _role == 'Investor',
                      child: _buildProfileInfo("Experience :", _experience),
                    ),
              if (_isEditing) const SizedBox(height: 20),
              if (_isEditing)
                ElevatedButton(
                    onPressed: _saveChanges, child: const Text("Save")),
              if (!_isEditing) const SizedBox(height: 20),
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 25),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
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
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 25),
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
    String? profile = await _prefs.getString('profile');
    debugPrint("${userData!.length}");

    setState(() {
      _role = profile!;
      if (profile == 'Investor') {
        _name = userData[0];
        _phone = userData[1];
        _email = userData[2];
        _address = userData[3];
        _occupation = userData[4];
        _experience = userData[5];
      }
      if (profile == 'Mentor') {
        _name = userData[0];
        _phone = userData[1];
        _email = userData[2];
        _address = userData[3];
      }
      if (profile == 'Student') {
        _name = userData[0];
        _phone = userData[1];
        _email = userData[2];
        _address = userData[3];
        _class = userData[4];
      }
    });
  }

  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveChanges() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    List<String> userDetails = [_name, _phone, _email, _class, _address];
    _prefs.setStringList('userDetails', userDetails);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Changes saved successfully')),
    );

    _toggleEditing();
  }
}
