import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/error_model.dart';
import '../utils/app_text.dart';

class FirestoreHelper {
  static const String usersCollection = "users";

  static Stream<QuerySnapshot<Map<String, dynamic>>> get users =>
      FirebaseFirestore.instance.collection(usersCollection).snapshots();

  static Future<bool> addData({
    required String id,
    required Map<String, dynamic> data,
  }) async {
    try {
      await FirebaseFirestore.instance
          .collection(usersCollection)
          .doc(id)
          .set(data);
      return true;
    } catch (e) {
      debugPrint("=======>   FIRESTORE CATCHE ERROR: $e");
      throw ErrorModel(
        code: AppText.unknown,
        message: AppText.somethingWentWrong,
      );
    }
  }
}
