/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';

// DataService just creat model for add my favirte to firebase store
class DataBaseService {
  String? userEmail = FirebaseAuth.instance.currentUser?.email;
  CollectionReference category = FirebaseFirestore.instance.collection(
    'category',
  );

  Future<void> addCategory(Map<String, String> data, {context}) async {
    final progress = ProgressHUD.of(context);
    // for delayoing the logout time
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
