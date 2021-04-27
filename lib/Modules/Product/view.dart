import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baazaru/Providers/product.dart';

class DetailPage extends StatefulWidget {
  DetailPage({Key key}) : super(key: key);
  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
