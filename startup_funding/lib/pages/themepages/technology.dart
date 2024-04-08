import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class TechnologyThemePage extends StatefulWidget {
  const TechnologyThemePage({Key? key}) : super(key: key);

  @override
  State<TechnologyThemePage> createState() => _TechnologyThemePageState();
}

class _TechnologyThemePageState extends State<TechnologyThemePage> {
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
        title: const Text("Technology"),
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
                return ListTile(
                  title: Text(
                    idea['ideaName'] as String? ?? 'Unnamed Idea',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Description: ${idea['description'] ?? 'No description'}'),
                  trailing: IconButton(
                      onPressed: () {}, icon: const Icon(Icons.interests)),
                  onTap: () async {
                    QuerySnapshot<Map<String, dynamic>> documentSnapshot =
                        await FirebaseFirestore.instance
                            .collection('users')
                            .where('uuid', isEqualTo: idea['userUUID'])
                            .get();
                    List<String> documentIds =
                        documentSnapshot.docs.map((doc) => doc.id).toList();

                    // Check if documentIds list is not empty before accessing its elements
                    if (documentIds.isNotEmpty) {
                      print(documentSnapshot.docs[0]['email']);
                      print(documentIds[0]);
                    } else {
                      print('No user found for this idea.');
                    }
                  },
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
        .where('theme', isEqualTo: 'Technology')
        .get();
    return querySnapshot.docs;
  }
}
