import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_funding/pages/login.dart';
import 'package:startup_funding/pages/tabs/blog.dart';
import 'package:startup_funding/pages/tabs/create_idea_tab.dart';
import 'package:startup_funding/pages/userProfile.dart';
import '../widgets/reg_widgets.dart';
import 'themepages/technology.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  RegistrationWidgets registrationWidgets = RegistrationWidgets();
  Set<String> _options = {};

  @override
  void initState() {
    // TODO: implement initState
    getProfile();
    super.initState();
  }

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
              SharedPreferences _prefs = await SharedPreferences.getInstance();
              _prefs.clear();
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
              return _options.map((String choice) {
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
              Text(
                " StartUpThemes ",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              RegistrationWidgets.ThemeCardsGroup(context),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200], // Change the background color here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "About Us", // Add this heading
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text(
                        "Welcome to StartUp hub, your go-to destination for connecting students, investors, and mentors in the exciting world of entrepreneurship and innovation. Our platform is dedicated to fostering collaboration, facilitating funding opportunities, and empowering aspiring entrepreneurs to turn their ideas into successful ventures.\n\nAt IMCC StartUp Hub, we are guided by our core values of innovation, collaboration, and integrity. We are committed to providing a transparent and inclusive platform that fosters creativity, nurtures talent, and promotes ethical entrepreneurship. Our dedication to user satisfaction and trust forms the foundation of everything we do.",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: Colors.grey[200], // Change the background color here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact Us", // Add this heading
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    RegistrationWidgets.ContactUsForm(context),
                  ],
                ),
              ),
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

  Future<void> getProfile() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var profile = _prefs.getString('profile');

    print("profile : $profile");
    if (profile == "Investor") {
      _options = {'Blog'};
    } else if (profile == "Student") {
      _options = {'Blog', 'Create Idea'};
    } else {
      _options = {'Blog', 'Write blog'};
    }
  }
}
