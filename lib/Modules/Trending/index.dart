import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:baazaru/Models/product.dart';
import 'package:baazaru/Providers/product.dart';

class TrendingPage extends StatefulWidget {
  TrendingPage({Key? key}) : super(key: key);
  @override
  _TrendingPageState createState() => _TrendingPageState();
}

class _TrendingPageState extends State<TrendingPage> {
  @override
  Widget build(BuildContext context) {
    final list = Provider.of<ProductProvider>(context);
    list.fetchProductFromProvider();

    return Scaffold(
      appBar: AppBar(
        title: Text("Trending Products"),
        backgroundColor: Colors.indigo,
      ),
      body: list.productList == null
          ? Text('loading')
          : ListView.separated(
              itemBuilder: (context, index) {
                Product product = list.productList[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(product.name[0].toUpperCase()),
                  ),
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(product.id.toString()),
                    ],
                  ),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.menu,
                    ),
                    onPressed: () {},
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider(
                  color: Colors.red,
                  height: 5,
                );
              },
              itemCount: list.productList.length,
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
