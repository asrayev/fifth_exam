
import 'package:fifth_exam/data/models/users_model.dart';
import 'package:flutter/material.dart';

import '../data/reopository/users_repository.dart';

class UserViewModel extends ChangeNotifier{
  UserViewModel ({required UserRepository userRepository}){
    _userReposit = userRepository;
    fetchAllUsers();
  }
  late UserRepository _userReposit;

  bool isLoading = false;

  List<UsersModel>? userModel;

  fetchAllUsers() async {
    notify(true);
    userModel = await _userReposit.getAllUserDio();
    notify(false);
  }

  notify(bool v){
    isLoading = v;
    notifyListeners();
  }
}