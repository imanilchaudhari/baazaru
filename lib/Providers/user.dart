import 'package:flutter/cupertino.dart';
import 'package:baazaru/Models/user.dart';
import 'package:baazaru/Services/user.dart';

class UserProvider extends ChangeNotifier {
  List<User> _users;

  List<User> get productList => _users;

  set productList(List<User> newList) {
    _users = newList;
    notifyListeners();
  }

  Future<List<User>> getFeaturedUsers() async {
    productList = await UserService.getAll();
    return productList;
  }
}
