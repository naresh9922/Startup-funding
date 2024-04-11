import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:startup_funding/pages/tabs/blog.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class BlogForm extends StatefulWidget {
  const BlogForm({Key? key}) : super(key: key);

  @override
  State<BlogForm> createState() => _BlogFormState();
}

class _BlogFormState extends State<BlogForm> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Write Blog'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _contentController,
                maxLines: 5, // Allow unlimited number of lines
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  labelText: 'Content',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null; // Return null if the input is valid
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: createBlog,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.purple),
                ),
                child: Text(
                  'Publish',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16.0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> createBlog() async {
    CollectionReference blog = FirebaseFirestore.instance.collection('blog');
    var uuid = const Uuid().v1();
    await blog.add({
      'uuid': uuid,
      'title': _titleController.text,
      'description': _contentController.text,
      'date': DateFormat('dd MMMM yyyy').format(DateTime.now())
    }).then((value) {
      debugPrint(" ${_titleController.text} Added ");
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BlogTab()));
    }).catchError((error) {
      debugPrint("Failed to add : $error");
    });
  }
}
