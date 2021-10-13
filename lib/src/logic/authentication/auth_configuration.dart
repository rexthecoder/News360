import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:news360/src/logic/model/user_models/user_data_model.dart';

import 'error_tracker.dart';

class AuthConfiguration with UiLoggy, ErrorTracker {
  //Init firebase auth instance
  FirebaseAuth auth = FirebaseAuth.instance;

  //Userdata
  UserResponseModel user = UserResponseModel();

  /// Method to create a new user a
  /// @Param
  /// email = "test@gmail.com", password = "******", username = "news360"
  Future<void> createUser(
    context, {
    required String email,
    required String password,
    required String username,
  }) async {
    //Progress  dialog
    final progress = ProgressHUD.of(context);
    progress?.showWithText('Loading...');
    try {
      await createUserWithEmail(email, password, username, progress);
    } on FirebaseAuthException catch (e) {
      firebaseErrorTracker(e, context, email, progress);
    } catch (e) {
      progress?.dismiss();
      showToast(
        e.toString(),
        context: context,
      );
    }
  }

// Firebase  processing is done here
  Future<void> createUserWithEmail(
      String email, String password, String username, progress) async {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    updateUsername(username: username);
    progress?.dismiss();
    Get.toNamed('/favorite');
  }

  /// Method to update user name
  /// @Param
  /// username = "news360"
  Future<void> updateUsername({
    required String username,
  }) async {
    try {
      await auth.currentUser!.updateDisplayName(username);
    } catch (e) {
      logError(e.toString());
    }
  }

  User? userInfo() {
    try {
      return auth.currentUser;
    } catch (e) {
      logError(e.toString());
    }
  }

  Future<void> loginUser(
    context, {
    required String email,
    required String password,
  }) async {
    //Progress  dialog
    final progress = ProgressHUD.of(context);
    progress?.showWithText('Loading...');
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      progress?.dismiss();
      Get.toNamed('/home');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        logDebug('No user found for that email.');
        progress?.dismiss();
        showToast('No user found for that email.', context: context);
      } else if (e.code == 'wrong-password') {
        logDebug('Wrong password provided for that user.');
        progress?.dismiss();
        showToast('Wrong password provided for that user.', context: context);
      } else {
        progress?.dismiss();
        showToast('$e', context: context);
      }
    }
  }
}
