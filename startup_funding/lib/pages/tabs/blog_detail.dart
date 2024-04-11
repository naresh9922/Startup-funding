import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../model/blog.dart';

class BlogDetailsScreen extends StatelessWidget {
  final BlogPost blogPost;

  BlogDetailsScreen(this.blogPost);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          blogPost.title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                blogPost.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(blogPost.fullContent),
            ),
          ],
        ),
      ),
    );
  }
}
