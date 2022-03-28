import 'package:flutter/material.dart';
import 'package:livechat/models/user_model.dart';

class UsersProvider extends ChangeNotifier{
  List<UserModel> _userList = [];

  List<UserModel> get userList => _userList;

  UserModel _currentUser = UserModel();
  UserModel _receiverUser = UserModel();

  UserModel get receiverUser => _receiverUser;

  set receiverUser(UserModel value) {
    _receiverUser = value;
  }

  UserModel get currentUser => _currentUser;

  set currentUser(UserModel value) {
    _currentUser = value;
    notifyListeners();
  }

  set userList(List<UserModel> value) {
    _userList = value;
    notifyListeners();
  }
}
