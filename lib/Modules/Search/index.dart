import 'package:flutter/material.dart';

import 'package:baazaru/Classes/search.dart';
import 'package:baazaru/Models/product.dart';
import 'package:baazaru/Providers/product.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as SearchArguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Products"),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              searchBox(args, context),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget searchBox(args, context) {
    return Stack(
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: 20, right: 20, top: 15),
          child: Material(
            borderRadius: BorderRadius.circular(5.0),
            elevation: 10,
            child: Container(
              child: TextFormField(
                initialValue: args.query,
                cursorColor: Colors.indigo[900],
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  suffixIcon: Icon(
                    Icons.search,
                    color: Colors.indigo[900],
                    size: 30,
                  ),
                  hintText: "What're you looking for?",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    borderSide: BorderSide.none,
                  ),
                ),
                onFieldSubmitted: (String value) {
                  print('Value for field saved as "$value"');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchPage(),
                      // Pass the arguments as part of the RouteSettings. The
                      // DetailScreen reads the arguments from these settings.
                      settings: RouteSettings(
                        arguments: SearchArguments(value),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
