// ignore_for_file: unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../helpers/firebase_auth_helper.dart';
import '../../helpers/firestore_helper.dart';
import '../../models/error_model.dart';
import '../../utils/app_color.dart';

class AuthProvider extends ChangeNotifier {
  bool _signInLoading = false;
  bool get signInLoading => _signInLoading;
  void onChangeSignInLoading(bool value) {
    _signInLoading = value;
    notifyListeners();
  }

  bool _signUpLoading = false;
  bool get signUpLoading => _signUpLoading;
  void onChangeSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  void checkLoginSession({
    required Function() onLoggedIn,
    required Function() onNotLoggedIn,
  }) async {
    try {
      final bool isUserLoggedIn = await FirebaseAuthHelper.checkLoginSession();
      if (isUserLoggedIn) {
        onLoggedIn();
      } else {
        onNotLoggedIn();
      }
    } catch (e) {
      onNotLoggedIn();
    }
  }

  void signUp({
    required String name,
    required String email,
    required String password,
    required Function() onSuccess,
  }) async {
    onChangeSignUpLoading(true);
    try {
      final UserCredential credentials = await FirebaseAuthHelper.createUser(
        email: email,
        password: password,
      );
      await FirestoreHelper.addData(
        id: credentials.user!.uid,
        data: {
          "name": name,
          "email": email,
        },
      );
      onSuccess();
    } catch (e) {
      Fluttertoast.showToast(
        backgroundColor: AppColor.appRed,
        msg: (e as ErrorModel).message,
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      onChangeSignUpLoading(false);
    }
  }

  void login({
    required String email,
    required String password,
    required Function() onSuccess,
  }) async {
    onChangeSignInLoading(true);
    try {
      final UserCredential credentials = await FirebaseAuthHelper.signIn(
        email: email,
        password: password,
      );
      onSuccess();
    } catch (e) {
      Fluttertoast.showToast(
        backgroundColor: AppColor.appRed,
        msg: (e as ErrorModel).message,
        toastLength: Toast.LENGTH_LONG,
      );
    } finally {
      onChangeSignInLoading(false);
    }
  }

  void logout({
    required Function() onSuccess,
  }) async {
    try {
      await FirebaseAuth.instance.signOut();
      onSuccess();
    } catch (e) {
      Fluttertoast.showToast(
        backgroundColor: AppColor.appRed,
        msg: (e as ErrorModel).message,
        toastLength: Toast.LENGTH_LONG,
      );
    }
  }
}
