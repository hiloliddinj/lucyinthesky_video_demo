import 'package:flutter/material.dart';

class MeScreen extends StatelessWidget {
  const MeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Text(
          'Me Screen',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
