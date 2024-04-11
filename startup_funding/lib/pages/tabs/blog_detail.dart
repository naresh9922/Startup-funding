import 'package:flutter/material.dart';

class BlogDetailsScreen extends StatefulWidget {
  final String title;
  final String date;
  final String description;

  BlogDetailsScreen({
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  State<BlogDetailsScreen> createState() => _BlogDetailsScreenState();
}

class _BlogDetailsScreenState extends State<BlogDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.blue[100],
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  widget.title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  widget.date,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Divider(), // Add a divider between date and description
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(widget.description),
            ),
          ],
        ),
      ),
    );
  }
}
