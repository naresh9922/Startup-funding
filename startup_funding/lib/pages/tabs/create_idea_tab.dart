import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_funding/pages/home.dart';
import 'package:uuid/uuid.dart';

class CreateIdeaTab extends StatefulWidget {
  const CreateIdeaTab({super.key});

  @override
  State<CreateIdeaTab> createState() => _CreateIdeaTabState();
}

class _CreateIdeaTabState extends State<CreateIdeaTab> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _ideaNameController = TextEditingController();
  final TextEditingController _problemStatementController =
      TextEditingController();
  final TextEditingController _partnersController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late String? selectedTheme;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Create Idea "),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _ideaNameController,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter Idea Name'
                        : null,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Idea Name ",
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _problemStatementController,
                    keyboardType: TextInputType.text,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter Problem Statement '
                        : null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Problem Statement  ",
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    controller: _partnersController,
                    keyboardType: TextInputType.number,
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter Partners '
                        : null,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Partners ",
                      labelStyle:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: DropdownButtonFormField(
                    items: [
                      'Technology',
                      'Health & Wellness',
                      'Education',
                      'Food',
                      'Finance',
                      'Other'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    validator: (value) =>
                        value == null ? 'Select Theme ' : null,
                    hint: const Text(
                      "Select Theme ",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (String? value) {
                      selectedTheme = value!.trim();
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: TextFormField(
                    validator: (value) => value == null || value.isEmpty
                        ? 'Enter Description '
                        : null,
                    controller: _descriptionController,
                    keyboardType: TextInputType.text,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Description of Idea',
                      alignLabelWithHint: true,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: double.infinity,
                  child: ElevatedButton(
                    style: const ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll(Colors.deepPurple),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        createIdea();
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        " Create ",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> createIdea() async {
    CollectionReference idea = FirebaseFirestore.instance.collection('ideas');
    var uuid = const Uuid().v1();
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var userUUID = await _prefs.getString('userUUID');
    try {
      await idea.add({
        'uuid': uuid,
        'userUUID': userUUID,
        'ideaName': _ideaNameController.text,
        'problemStatement': _problemStatementController.text,
        'partners': _partnersController.text,
        'theme': selectedTheme!.trim(),
        'description': _descriptionController.text
      }).then((value) {
        debugPrint("Idea Added ");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Idea registered successfully'),
          ),
        );
        Navigator.pop(context);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Home(),
          ),
        );
      }).catchError((error) {
        debugPrint("Failed : $error");
        return error;
      });
    } catch (e) {
      debugPrint("Error  : $e");
    }
  }
}
