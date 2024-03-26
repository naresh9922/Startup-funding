import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:startup_funding/pages/login.dart';
import 'package:startup_funding/pages/registration.dart';
import 'home.dart';
import 'tabs/blog.dart';

import 'tabs/blog_detail.dart';
import 'tabs/create_idea_tab.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen>
    with SingleTickerProviderStateMixin {
  late bool? loggedIn;
  @override
  void initState() {
    super.initState();
    loggedIn = isLoggedIn() as bool?;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => loggedIn! ? const Home() : Login(),
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
        colors: [Colors.blue, Colors.pink],
        begin: Alignment.topRight,
        end: Alignment.bottomLeft,
      )),
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Welcome to Startup Funding',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 35,
            ),
          )
        ],
      ),
    ));
  }

  Future<bool?> isLoggedIn() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    setState(() {
      loggedIn = _prefs.getBool('loggedIn');
    });
    return loggedIn;
  }
}
