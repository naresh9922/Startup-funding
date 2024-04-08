import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:startup_funding/pages/themepages/education.dart';
import 'package:startup_funding/pages/themepages/finance.dart';
import 'package:startup_funding/pages/themepages/food.dart';
import 'package:startup_funding/pages/themepages/health_and_wellness.dart';
import 'package:startup_funding/pages/themepages/other.dart';
import 'package:startup_funding/pages/themepages/technology.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:startup_funding/widgets/registration_form_widgets.dart';

class RegistrationWidgets {
  static List<String> themes = [
    'Technology',
    'Health & Wellness',
    'Education',
    'Food',
    'Finance',
    'Others'
  ];

  static Widget AdsCarousel() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 5,
            spreadRadius: -1,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: CarouselSlider(
        options: CarouselOptions(height: 180, autoPlay: true),
        items: [1, 2, 3].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                ),
                child: Text(
                  'text $i',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }

  static Widget ContactUsForm(BuildContext context) {
    void _openUrl(String url) async {
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          color: Colors.grey[200],
          child: Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(width: 8),
                      Text(
                        "Address:",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Beside IMCC College, Kothurd, Pune - 401037",
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.phone),
                      SizedBox(width: 8),
                      Text(
                        "Phone: 1234567890, 0987654321",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.email),
                      SizedBox(width: 8),
                      Text(
                        "Email: milkeasy1234@gmail.com",
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _openUrl('https://www.facebook.com/');
                        },
                        child: Icon(Icons.facebook),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          _openUrl('https://www.instagram.com/');
                        },
                        child: Icon(Icons.facebook, color: Colors.pink),
                      ),
                      SizedBox(width: 16),
                      GestureDetector(
                        onTap: () {
                          _openUrl('https://www.twitter.com/');
                        },
                        child: Icon(Icons.facebook, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  static Widget ThemeCardsGroup(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: <Widget>[
        ThemeCard("Technology", context, Colors.blue),
        ThemeCard("Health & Wellness", context, Colors.green),
        ThemeCard("Finance", context, Colors.orange),
        ThemeCard("Education", context, Colors.purple),
        ThemeCard("Food", context, Colors.red),
        ThemeCard("Other", context, Colors.teal),
      ],
    );
  }

  static Widget ThemeCard(
    String themeName,
    BuildContext context,
    Color color,
  ) {
    void _navigateToTheme(BuildContext context, String themeName) {
      switch (themeName) {
        case "Technology":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TechnologyThemePage(),
            ),
          );
          break;
        case "Education":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Education(),
            ),
          );
          break;
        case "Finance":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Finance(),
            ),
          );
          break;
        case "Food":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Food(),
            ),
          );
          break;
        case "Health & Wellness":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const HealthAndWellness(),
            ),
          );
          break;
        case "Other":
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Other(),
            ),
          );
          break;
        default:
          debugPrint("Invalid theme selected");
          break;
      }
    }

    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
        ),
        height: 120,
        width: 120,
        child: Center(
          child: Text(
            themeName,
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      onTap: () {
        _navigateToTheme(context, themeName);
      },
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
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
                "StartUpThemes",
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
                "About Us",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16.0),
                child: const Text(
                    "Welcome to StartUp hub, your go-to destination for connecting students, investors, and mentors in the exciting world of entrepreneurship and innovation. Our platform is dedicated to fostering collaboration, facilitating funding opportunities, and empowering aspiring entrepreneurs to turn their ideas into successful ventures. At IMCC StartUp Hub, we are guided by our core values of innovation, collaboration, and integrity. We are committed to providing a transparent and inclusive platform that fosters creativity, nurtures talent, and promotes ethical entrepreneurship. Our dedication to user satisfaction and trust forms the foundation of everything we do."),
              ),
              const SizedBox(
                height: 20,
              ),
              RegistrationWidgets.ContactUsForm(context),
            ],
          ),
        ),
      ),
    );
  }
}
