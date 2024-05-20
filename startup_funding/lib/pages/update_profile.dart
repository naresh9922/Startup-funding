import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IdeaDetailsPage extends StatefulWidget {
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
  State<IdeaDetailsPage> createState() => _IdeaDetailsPageState();
}

class _IdeaDetailsPageState extends State<IdeaDetailsPage> {
  String? role = '';

  @override
  void initState() {
    // TODO: implement initState
    getRole();
    super.initState();
  }

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
            Text(widget.ideaName),
            const SizedBox(height: 16.0),
            const Text(
              'Description:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.description),
            const SizedBox(height: 16.0),
            const Text(
              'Theme:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.theme),
            const SizedBox(height: 16.0),
            const Text(
              'Partners:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.partners),
            const SizedBox(height: 16.0),
            const Text(
              'Problem Statement:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(widget.problemStatement),
            const SizedBox(height: 16.0),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                  List<String>? userDetails =
                      await _prefs.getStringList('userDetails');
                  print(userDetails);
                  QuerySnapshot<Map<String, dynamic>> documentSnapshot =
                      await FirebaseFirestore.instance
                          .collection('users')
                          .where('uuid', isEqualTo: widget.userUUID)
                          .get();
                  List<String> documentIds =
                      documentSnapshot.docs.map((doc) => doc.id).toList();
                  if (documentIds.isNotEmpty) {
                    print(documentSnapshot.docs[0]['email']);
                    print(documentIds[0]);
                  } else {
                    print('No user found for this idea.');
                  }
                  debugPrint(
                      "Hello ${documentSnapshot.docs[0]['name']}, Your profile Viewed by  ${userDetails![0]} \n For Contact mail to ${userDetails[2]}");
                  // Future<void> sendEmail() async {
                  final username = 'getguruji1234@gmail.com';
                  final password = 'vroaaccameonlxjp';

                  final smtpServer = gmail(username, password);

                  final message = Message()
                    ..from = Address(username, 'Startup Hub')
                    ..recipients.add(documentSnapshot.docs[0]['email'])
                    ..subject =
                        "Regarding your startup idea listed on startup hub."
                    ..text =
                        "Hello ${documentSnapshot.docs[0]['name']},I hope you are doing grate.Mr.${userDetails[0]} has shown intrest in you startup idea. You can contact at ${userDetails[2]} this email for further details. Best of luck for your meeting with him.";

                  try {
                    final sendReport = await send(message, smtpServer);
                    print('Message sent: ' + sendReport.toString());
                  } catch (e) {
                    print('Error occurred while sending email: $e');
                  }
                  // }
                },
                style: ElevatedButton.styleFrom(
                  elevation: 5, // shadow elevation
                  padding: const EdgeInsets.symmetric(
                      vertical: 16, horizontal: 24), // button padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // button border
                  ),
                ),
                child: const Text('Interested'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> getRole() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    role = await _prefs.getString('profile');
    print(role);
  }
}
