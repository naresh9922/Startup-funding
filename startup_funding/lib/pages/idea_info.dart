import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class IdeaDetailsPage extends StatelessWidget {
  final String description;
  final String ideaName;
  final String partners;
  final String problemStatement;
  final String theme;
  final String userUUID;
  final String uuid;

  IdeaDetailsPage({
    required this.description,
    required this.ideaName,
    required this.partners,
    required this.problemStatement,
    required this.theme,
    required this.userUUID,
    required this.uuid,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Idea Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Idea Name:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(ideaName),
            const SizedBox(height: 16.0),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(description),
            const SizedBox(height: 16.0),
            const Text(
              'Theme:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(theme),
            const SizedBox(height: 16.0),
            const Text(
              'Partners:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(partners),
            const SizedBox(height: 16.0),
            const Text(
              'Problem Statement:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(problemStatement),
            const SizedBox(height: 16.0),
            // Text(
            //   'User UUID:',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // Text(userUUID),
            // SizedBox(height: 16.0),
            // Text(
            //   'UUID:',
            //   style: TextStyle(fontWeight: FontWeight.bold),
            // ),
            // Text(uuid),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity, // Set width to 100%
              child: ElevatedButton(
                onPressed: () async {
                  QuerySnapshot<Map<String, dynamic>> documentSnapshot =
                      await FirebaseFirestore.instance
                          .collection('users')
                          .where('uuid', isEqualTo: userUUID)
                          .get();
                  List<String> documentIds =
                      documentSnapshot.docs.map((doc) => doc.id).toList();
                  if (documentIds.isNotEmpty) {
                    print(documentSnapshot.docs[0]['email']);
                    print(documentIds[0]);
                  } else {
                    print('No user found for this idea.');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // background color
                  onPrimary: Colors.white, // text color
                  elevation: 5, // shadow elevation
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 24), // button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // button border
                  ),
                ),
                child: const Text('Interested'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
