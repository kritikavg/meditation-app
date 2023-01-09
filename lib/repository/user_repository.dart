import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';

class UserRepository {
  Future<UserCredential?> registerUser({
    required String email,
    required String password,
    required String userName,
  }) async {
    try {
      var response = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
        email: email,
        password: password,
      )
          .then(
        (value) async {
          UserCredential? mainValue = value;
          log("[createUserWithEmailAndPassword] ${value.user.toString()}");
          if (value.user != null) {
            await value.user!.updateDisplayName(userName).then(
              (value) async {
                mainValue = await loginUser(
                  email: email,
                  password: password,
                );
              },
            );
          } else {
            throw Exception(
                "User got null cannot update username [updateDisplayName]");
          }
          return mainValue;
        },
      );
      return response;
    } catch (e) {
      log("error: [registerUser] $e");
      return null;
    }
  }

  Future<UserCredential?> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      var response = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return response;
    } catch (e) {
      log("error: [loginUser] $e");
      return null;
    }
  }

  void getDietData() {
    
  }
}
