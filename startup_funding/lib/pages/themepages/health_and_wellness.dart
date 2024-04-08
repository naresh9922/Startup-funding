import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
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
                    idea['ideaName'] as String, // Explicitly cast to String
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text('Description: ${idea['description']}'),
                  onTap: () {
                    // Handle onTap if needed
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
        .where('theme', isEqualTo: 'Health & Wellness')
        .get();
    return querySnapshot.docs;
  }
}
