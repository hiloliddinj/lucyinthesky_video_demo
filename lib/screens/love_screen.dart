import 'package:flutter/material.dart';

class LoveScreen extends StatelessWidget {
  const LoveScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Text(
          'Love Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
