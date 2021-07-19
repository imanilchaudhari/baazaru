import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baazaru/Providers/product.dart';

class ProductPage extends StatefulWidget {
  ProductPage({Key key}) : super(key: key);
  @override
  ProductlPageState createState() => ProductlPageState();
}

class ProductlPageState extends State<ProductPage> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ProductProvider>(context);
    list.fetchProductFromProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Products"),
      ),
      body: Text('loading'),
    );
  }
}
