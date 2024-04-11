import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/blog.dart';
import 'blog_detail.dart';

class BlogTab extends StatefulWidget {
  const BlogTab({Key? key});

  @override
  State<BlogTab> createState() => _BlogTabState();
}

class _BlogTabState extends State<BlogTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blogs"),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('blog').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          final blogs = snapshot.data!.docs;
          return ListView.builder(
            itemCount: blogs.length,
            itemBuilder: (context, index) {
              final blogData = blogs[index].data() as Map<String, dynamic>;
              return Card(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(
                    blogData['title'] ?? 'No Title',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.brown), // Custom font size and color
                  ),
                  subtitle: Text(
                    blogData['date'] ?? 'No Date',
                    style: TextStyle(
                      fontSize: 11,
                    ),
                  ), // Added subtitle for date
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BlogDetailsScreen(
                          title: blogData['title'],
                          date: blogData['date'],
                          description: blogData['description'],
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
