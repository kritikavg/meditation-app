import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:fit_memoir/repository/user_repository.dart';
import 'package:flutter/material.dart';

class UserDetailsProvider extends ChangeNotifier {
  UserCredential? userDetails;
  UserRepository userRepo = UserRepository();
  bool isLoading = false;

  Future<bool> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      userDetails = await userRepo
          .loginUser(
        email: email,
        password: password,
      )
          .then(
        (value) {
          log("[loginUser] ${value!.user.toString()}");
          return value;
        },
      );
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      log("error: [pvd loginUser] $e");
      return false;
    }
  }

  Future<bool> registerUser({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      isLoading = true;
      notifyListeners();
      userDetails = await userRepo
          .registerUser(
        email: email,
        password: password,
        userName: userName,
      )
          .then((value) {
        log("[registerUser] ${value!.user.toString()}");
        return value;
      });
      isLoading = false;
      notifyListeners();
      return true;
    } catch (e) {
      log("error: [pvd registerUser] $e");
      return false;
    }
  }

  void logout() {
    userDetails = null;
    notifyListeners();
  }
}
