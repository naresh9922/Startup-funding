import 'package:flutter/material.dart';

class BlogForm extends StatefulWidget {
  const BlogForm({super.key});

  @override
  State<BlogForm> createState() => _BlogFormState();
}

class _BlogFormState extends State<BlogForm> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          child: Column(
            children: [
              TextFormField(),
            ],
          ),
        ),
      ),
    );
  }
}
