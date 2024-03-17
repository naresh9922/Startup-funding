import 'package:flutter/material.dart';

class TechnologyThemePage extends StatefulWidget {
  const TechnologyThemePage({super.key});

  @override
  State<TechnologyThemePage> createState() => _TechnologyThemePageState();
}

class _TechnologyThemePageState extends State<TechnologyThemePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Technology"),
      ),
    );
  }
}
