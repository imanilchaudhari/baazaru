import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baazaru/Models/product.dart';
import 'package:baazaru/Providers/product.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key key}) : super(key: key);
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ProductProvider>(context);
    list.fetchProductFromProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products"),
      ),
      body: Text('loading'),
    );
  }
}
