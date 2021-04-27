import 'package:flutter/cupertino.dart';
import 'package:baazaru/Models/product.dart';
import 'package:baazaru/Services/product.dart';

class ProductProvider extends ChangeNotifier {
  List<Product> _products;

  List<Product> get productList => _products;

  set productList(List<Product> newList) {
    _products = newList;
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
}
