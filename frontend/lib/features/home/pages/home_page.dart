import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  static MaterialPageRoute route() =>
      MaterialPageRoute(builder: (context) => HomePage());
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Hai'));
  }
}
