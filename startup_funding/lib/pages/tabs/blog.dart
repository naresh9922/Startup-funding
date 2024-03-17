import 'package:flutter/material.dart';

import '../../model/blog.dart';
import 'blog_detail.dart';

class BlogTab extends StatefulWidget {
  const BlogTab({super.key});

  @override
  State<BlogTab> createState() => _BlogTabState();
}

class _BlogTabState extends State<BlogTab> {
  final List<BlogPost> blogPosts = [
    BlogPost(
      imageUrl:
          'https://assets.materialup.com/uploads/d5690600-afa9-424d-b7c8-eee7a78f0847/preview.jpg',
      title: 'The Journey of Flutter',
      postingTime: 'Mar 15 • 5 min read',
      fullContent: 'Flutter has revolutionized mobile app development...',
    ),
    BlogPost(
      imageUrl:
          'https://cdn.dribbble.com/users/4110848/screenshots/16466711/media/48ee08ce3ea5ea3f21fc5d23307134ac.png?resize=400x0',
      title: 'Understanding State Management',
      postingTime: 'Mar 20 • 7 min read',
      fullContent: 'State management is a key concept in Flutter...',
    ),
    BlogPost(
      imageUrl:
          'https://cdn.dribbble.com/users/978267/screenshots/9169084/blog_post_4x.png',
      title: 'Building Responsive UIs',
      postingTime: 'Apr 5 • 6 min read',
      fullContent: 'Responsive design is essential for any mobile app...',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
      ),
      body: ListView.builder(
        itemCount: blogPosts.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlogDetailsScreen(blogPosts[index]),
                  ),
                );
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      blogPosts[index].imageUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            blogPosts[index].title,
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(
                            blogPosts[index].postingTime,
                            style: TextStyle(fontWeight: FontWeight.w300),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
