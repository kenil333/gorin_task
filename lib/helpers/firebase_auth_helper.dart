import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/error_model.dart';
import '../utils/app_text.dart';

class FirebaseAuthHelper {
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  static Future<UserCredential> createUser({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("=======>   FIREBASE AUTH EXCEPTION: $e");
      throw ErrorModel(
          code: e.code, message: e.message ?? AppText.somethingWentWrong);
    } catch (e) {
      debugPrint("=======>   FIREBASE AUTH CATCHE ERROR: $e");
      throw ErrorModel(
        code: AppText.unknown,
        message: AppText.somethingWentWrong,
      );
    }
  }

  static Future<UserCredential> signIn({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      debugPrint("=======>   FIREBASE AUTH EXCEPTION: $e");
      throw ErrorModel(
        code: e.code,
        message: e.message ?? AppText.somethingWentWrong,
      );
    } catch (e) {
      debugPrint("=======>   FIREBASE AUTH CATCHE ERROR: $e");
      throw ErrorModel(
        code: AppText.unknown,
        message: AppText.somethingWentWrong,
      );
    }
  }

  static Future<bool> checkLoginSession() async {
    try {
      return _firebaseAuth.currentUser != null;
    } catch (e) {
      debugPrint("=======>   FIREBASE AUTH CHECK LOGIN SESSION ERROR: $e");
      throw ErrorModel(
        code: AppText.unknown,
        message: AppText.somethingWentWrong,
      );
    }
  }

  static Future<bool> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return true;
    } catch (e) {
      debugPrint("=======>   FIREBASE AUTH SIGN OUT ERROR: $e");
      throw ErrorModel(
        code: AppText.unknown,
        message: AppText.somethingWentWrong,
      );
    }
  }
}
