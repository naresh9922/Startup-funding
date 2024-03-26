import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_funding/pages/login.dart';
import 'package:startup_funding/pages/tabs/blog.dart';
import 'package:startup_funding/pages/tabs/create_idea_tab.dart';
import 'package:startup_funding/pages/userProfile.dart';
import '../widgets/reg_widgets.dart';
import 'themepages/technology.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RegistrationWidgets registrationWidgets = RegistrationWidgets();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Home "),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserProfile(),
                ),
              );
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () async {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const Login(),
                ),
              );
            },
            icon: const Icon(Icons.logout),
          ),
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return {'Blog', 'Subscribe', 'Create Idea', 'Successful Deals'}
                  .map((String choice) {
                return PopupMenuItem<String>(
                  value: choice,
                  child: Text(choice),
                );
              }).toList();
            },
            onSelected: (value) {
              if (value == "Blog") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const BlogTab(),
                  ),
                );
              }
              if (value == "Create Idea") {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateIdeaTab(),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RegistrationWidgets.AdsCarousel(),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Themes ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RegistrationWidgets.ThemeCardsGroup(context),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "About Us", // Add this heading
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                    "Our dairy buy milk direct from farmer in reasonable price. we decide milk price on basis of fat present in the milk provided by farmer in front of them by testing milk fat in machine. We do all transactions in transparant manner. Farmer and collector can  view their provided milk and collected milk respectively and also can view payment status also. If you want to become a member of out MilkEasy family please contact us on given contact details."),
              ),
              const SizedBox(
                height: 20,
              ),
              RegistrationWidgets.ContactUsForm(),
              RegistrationWidgets.FeedbackForm()
            ],
          ),
        ),
      ),
    );
  }

  void handleClick(String value) {
    switch (value) {
      case 'Logout':
        debugPrint("Logout");
        break;
      case 'Settings':
        debugPrint("");
        break;
    }
  }
}
