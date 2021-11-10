import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:lucyinthesky_video_demo/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:lucyinthesky_video_demo/models/video_product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController controller = PageController(initialPage: 0);

  Future getInputData() async {
    var response = await http.get(Uri.https(
        'lucy-test1.s3.amazonaws.com', 'response_1632323783535.json'));

    var jsonData = jsonDecode(response.body);
    List<Product> products = [];
    //final String image, price, name, regularVideo, regularVideoPoster, special;

    for (var u in jsonData['data']) {
      Product product = Product(u['image'], u['price'], u['name'],
          u['regularVideo'], u['regularVideoPoster'], u['special']);
      products.add(product);
    }
    return products;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInputData(),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.data == null) {
          return const Center(
              child: CircularProgressIndicator(
            color: Colors.white,
          ));
        } else {
          return PageView.builder(
            controller: controller,
            scrollDirection: Axis.vertical,
            itemCount: snapshot.data!.length,
            itemBuilder: (context, i) {
              return VideoProduct(product: snapshot.data[i]);
            },
          );
        }
      },
    );
  }
}
