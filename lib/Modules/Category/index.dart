import 'package:flutter/material.dart';
import 'package:baazaru/Classes/category.dart';

class CategoryPage extends StatefulWidget {
  CategoryPage({Key? key}) : super(key: key);
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as CategoryArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Category Page ${args.id}"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
