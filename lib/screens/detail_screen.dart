import 'package:flutter/material.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, this.productName}) : super(key: key);

  static const String id = 'DetailScreen';

  final String? productName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('Product Details Screen',
                  style: TextStyle(color: Colors.blueAccent, fontSize: 20)),
              const SizedBox(
                height: 40,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('GO BACK',
                      style: TextStyle(color: Colors.white, fontSize: 20)))
            ],
          ),
        ),
      ),
    );
  }
}
