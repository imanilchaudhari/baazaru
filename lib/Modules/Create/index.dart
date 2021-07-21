import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baazaru/Models/product.dart';
import 'package:baazaru/Providers/product.dart';

class CreatePage extends StatefulWidget {
  CreatePage({Key? key}) : super(key: key);
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ProductProvider>(context);
    list.fetchProductFromProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text("Create Products"),
        backgroundColor: Colors.indigo,
      ),
      body: Text(
        'Loading ...',
        textAlign: TextAlign.center,
      ),
    );
  }
}
