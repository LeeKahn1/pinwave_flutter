import 'package:flutter/material.dart';
import 'package:tubes_pinwave/module/welcome/welcome_page.dart';

void main() {
  runApp(const PinWave());
}

class PinWave extends StatelessWidget {
  const PinWave({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WelcomePage(),
    );
  }
}