import 'package:flutter/cupertino.dart';
import 'package:baazaru/Models/product.dart';
import 'package:baazaru/Services/product.dart';

class ProductProvider extends ChangeNotifier {
  late List<Product> _items;

  List<Product> get productList => _items;

  set productList(List<Product> newList) {
    _items = newList;
    notifyListeners();
  }

  Future<List<Product>> fetchProductFromProvider() async {
    productList = await ProductService.getAll();
    return productList;
  }

  Future<List<Product>> getTrendingProducts() async {
    productList = await ProductService.getAll();
    return productList;
  }

  Future<List<Product>> getFeaturedProducts() async {
    productList = await ProductService.getAll();
    return productList;
  }
}
