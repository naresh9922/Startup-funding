import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../idea_info.dart';

class HealthAndWellness extends StatefulWidget {
  const HealthAndWellness({Key? key}) : super(key: key);

  @override
  State<HealthAndWellness> createState() => _TechnologyThemePageState();
}

class _TechnologyThemePageState extends State<HealthAndWellness> {
  late Future<List<DocumentSnapshot>> ideasFuture;

  @override
  void initState() {
    super.initState();
    ideasFuture = getIdeas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HealthAndWellness"),
      ),
      body: FutureBuilder<List<DocumentSnapshot>>(
        future: ideasFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            // Specific error handling
            if (snapshot.error is FirebaseException) {
              FirebaseException error = snapshot.error as FirebaseException;
              return Center(
                child: Text('Firestore Error: ${error.message}'),
              );
            } else {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            }
          } else if (snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Data'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var idea =
                    snapshot.data![index].data()! as Map<String, dynamic>;
                return Card(
                  color: Colors.grey[200], // Set background color to grey 200
                  child: ListTile(
                    title: Text(
                      idea['ideaName'] as String? ?? 'Unnamed Idea',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Problem Statement: ${idea['problemStatement'] ?? 'No description'}',
                    ),
                    onTap: () async {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => IdeaDetailsPage(
                            description: idea['description'],
                            ideaName: idea['ideaName'],
                            partners: idea['partners'],
                            problemStatement: idea['problemStatement'],
                            theme: idea['theme'],
                            userUUID: idea['userUUID'],
                            uuid: idea['uuid'],
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Future<List<DocumentSnapshot>> getIdeas() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('ideas')
        .where('theme', isEqualTo: 'Health & Wellness')
        .get();
    return querySnapshot.docs;
  }
}
