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

  void addCategory(Map<String, String> data, {context}) {
    final progress = ProgressHUD.of(context);
    Future.delayed(const Duration(seconds: 2), () {
      progress?.showWithText('Loading...');
    });

    try {
      category.doc(userEmail).set(data);
      progress?.dismiss();
      Get.toNamed('home');
    } catch (e) {
      progress?.dismiss();
      showToast('$e', context: context);
    }
  }
}
