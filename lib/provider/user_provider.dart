import 'package:flutter/material.dart';
import 'package:vedic_heals/models/user_model.dart';
import 'package:vedic_heals/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  UserModel? _userModel;
  UserModel get getUser => _userModel!;
  Future<void> refreshUser() async {
    UserModel userModel = await AuthService().getUserDetails();
    _userModel = userModel;
    notifyListeners();
  }
}
