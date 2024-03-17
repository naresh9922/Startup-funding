// ignore_for_file: non_constant_identifier_names

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:startup_funding/pages/themepages/technology.dart';

class RegistrationWidgets {
  static List themes = [
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
      decoration: BoxDecoration(boxShadow: const [
        BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 5,
            spreadRadius: -1),
      ], borderRadius: BorderRadius.circular(10), color: Colors.white),
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

  static Widget ContactUsForm() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.all(5),
          child: const Card(
            color: Color.fromARGB(255, 238, 238, 235),
            elevation: 20,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    // 1 address
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_city),
                          Text(" Address:")
                        ],
                      ),
                      Text("Beside Imcc college, Kothurd. Pune - 401037"),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Wrap(
                    children: [
                      Icon(Icons.phone),
                      Text(' Phone : 1234567890,  0987654321'),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Wrap(
                    children: [
                      Icon(Icons.email),
                      Text(' Email: milkeasy1234@gmail.com')
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Icon(Icons.facebook),
                      Icon(Icons.facebook),
                      Icon(Icons.facebook),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  static Widget FeedbackForm() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, left: 5, right: 5),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.brown),
          borderRadius: const BorderRadius.all(Radius.circular(10))),
      child: Column(
        children: [
          const Text('Feedback',
              style: TextStyle(fontSize: 30, color: Colors.brown)),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              // controller: nameController,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  labelText: ' Name',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)))),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: TextField(
              // controller: EmailController,
              decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  labelText: 'mobile no',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  )),
            ),
          ),
          const Form(
            // key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: TextField(
                // controller: FeedbackController,
                decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    labelText: 'Feedback',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    )),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Submit'),
            ),
          )
        ],
      ),
    );
  }

  static Widget ThemeCardsGroup(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 8.0,
      children: <Widget>[
        ThemeCard("Technology", context),
        ThemeCard("Health & Wellness", context),
        ThemeCard("Finance ", context),
        ThemeCard("Education ", context),
        ThemeCard("Food", context),
        ThemeCard("Other ", context),
      ],
    );
  }

  static Widget ThemeCard(
    String themeName,
    BuildContext context,
  ) {
    return GestureDetector(
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey,
        ),
        height: 120,
        width: 120,
        child: Text(themeName),
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const TechnologyThemePage(),
          ),
        );
        debugPrint("$themeName Clicked");
      },
    );
  }
}

class NavigateToTheme extends StatefulWidget {
  const NavigateToTheme({
    super.key,
    required Widget themeName,
    required Widget themePage,
  });

  @override
  State<NavigateToTheme> createState() => NavigateToThemeState();
}

class NavigateToThemeState extends State<NavigateToTheme> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey,
          ),
          height: 120,
          width: 120,
          child: Text("lol"),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TechnologyThemePage(),
            ),
          );
          debugPrint(" Clicked");
        });
  }
}
