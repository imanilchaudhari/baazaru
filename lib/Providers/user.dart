import 'package:flutter/cupertino.dart';
import 'package:baazaru/Models/user.dart';
import 'package:baazaru/Services/user.dart';

class UserProvider extends ChangeNotifier {
  late List<User> _items;

  List<User> get productList => _items;

  set productList(List<User> newList) {
    _items = newList;
    notifyListeners();
  }

  Future<List<User>> getFeaturedUsers() async {
    productList = await UserService.getAll();
    return productList;
  }
}
