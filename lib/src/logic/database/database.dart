//

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

class DataBaseService {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  CollectionReference category =
      FirebaseFirestore.instance.collection('category');

  Future<void> addCategory(Map<String, String> data, {context}) async {
    final progress = ProgressHUD.of(context);
    Future.delayed(const Duration(seconds: 5), () {
      progress?.showWithText('Loading...');
    });

    try {
      await category.doc(userEmail).set(data);
      progress?.dismiss();
      Get.offAndToNamed('home');
    } catch (e) {
      progress?.dismiss();
      showToast('$e', context: context);
    }
  }
}
