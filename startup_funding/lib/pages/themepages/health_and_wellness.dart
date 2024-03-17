import 'package:flutter/material.dart';

class HealthAndWellness extends StatefulWidget {
  const HealthAndWellness({super.key});

  @override
  State<HealthAndWellness> createState() => _HealthAndWellnessState();
}

class _HealthAndWellnessState extends State<HealthAndWellness> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Health & Wellness"),
      ),
    );
  }
}
