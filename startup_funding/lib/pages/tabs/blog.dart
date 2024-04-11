import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../model/blog.dart';
import 'blog_detail.dart';

class BlogTab extends StatefulWidget {
  const BlogTab({super.key});

  @override
  State<BlogTab> createState() => _BlogTabState();
}

class _BlogTabState extends State<BlogTab> {
  @override
  void initState() {
    super.initState();
    // getBlogs();
  }

  // final List<BlogPost> blogPosts = [
  //   BlogPost(
  //     title:
  //         '"Navigating the Startup Seas: A Guide for First-Time Entrepreneurs"',
  //     postingTime: 'Mar 15 ',
  //     fullContent:
  //         "Embarking on the journey of entrepreneurship can feel like setting sail into uncharted waters. In this blog, we'll explore essential tips and strategies to help first-time entrepreneurs navigate the startup landscape with confidence.",
  //     imageUrl: '',
  //   ),
  //   BlogPost(
  //     title:
  //         "The Art of Bootstrapping: Building a Startup on a Shoestring Budget",
  //     postingTime: 'Mar 20 ',
  //     fullContent:
  //         "Bootstrapping—building a startup from the ground up with minimal external funding—requires creativity, resourcefulness, and a willingness to think outside the box. In this blog, we'll explore the art of bootstrapping and share tips for launching and growing your startup on a shoestring budget.",
  //     imageUrl: '',
  //   ),
  //   BlogPost(
  //     title: 'startup transformation',
  //     postingTime: 'Mar 26• ',
  //     fullContent:
  //         "The startup landscape has undergone a dramatic transformation in recent years, evolving from a niche subculture to a global phenomenon. In this blog, we'll trace the evolution of startup culture and explore its impact on entrepreneurship and innovation worldwide.",
  //     imageUrl: '',
  //   ),
  //   BlogPost(
  //       title: "The Power of Purpose: Building a Purpose-Driven Startup",
  //       postingTime: 'Apr 1 • ',
  //       fullContent:
  //           "In an increasingly purpose-driven world, startups that prioritize social impact and sustainability are gaining traction. In this blog, we'll explore the importance of infusing purpose into your startup's DNA and how it can drive success and make a positive difference in the world",
  //       imageUrl: ''),
  //   BlogPost(
  //       title:
  //           "Disrupting the Status Quo: Embracing Innovation in the Startup World",
  //       postingTime: 'Apr 7 • ',
  //       fullContent:
  //           "Innovation lies at the heart of entrepreneurship, driving startups to challenge conventional wisdom, disrupt industries, and create new markets. In this blog, we'll explore the role of innovation in the startup world and how embracing a culture of experimentation and creativity can fuel success.",
  //       imageUrl: ''),
  // ];
  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(),
  //     body: StreamBuilder(
  //       stream: FirebaseFirestore.instance.collection('blog').snapshots(),
  //       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
  //         if (snapshot.connectionState == ConnectionState.waiting) {
  //           return Center(
  //             child: CircularProgressIndicator(),
  //           );
  //         }
  //         if (snapshot.hasError) {
  //           return Center(
  //             child: Text('Error: ${snapshot.error}'),
  //           );
  //         }
  //         final blogs = snapshot.data!.docs;
  //         return ListView.builder(
  //           itemCount: blogs.length,
  //           itemBuilder: (context, index) {
  //             final blog = blogs[index].data() as Map<String, dynamic>;
  //             return GestureDetector(
  //               // onTap: () {
  //               //   Navigator.push(
  //               //     context,
  //               //     // MaterialPageRoute(
  //               //       // builder: (context) => BlogDetailsScreen(blogPosts[index]),
  //               //     ),
  //               //   );
  //               // },
  //               child: ListTile(
  //                 title: Text(blog['title'] ?? 'No Title'),
  //                 // subtitle: Text(blog['description'] ?? 'No Content'),
  //               ),
  //             );
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
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
          return ListView(
            children: blogs.map((blogDoc) {
              final blogData = blogDoc.data() as Map<String, dynamic>;
              return Card(
                color: Colors.grey[200],
                child: ListTile(
                  title: Text(blogData['title'] ?? 'No Title'),
                  // subtitle: Text(blogData['description'] ?? 'No Content'),
                  onTap: () {
                    // Handle onTap if needed
                  },
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}


  // Future<void> getBlogs() async {}

