import 'package:firebase_auth/firebase_auth.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/logic/global/variables.dart';
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
  Future<dynamic> createUser({
    required String email,
    required String password,
    required String username,
  }) async {
    try {
      await createUserWithEmail(
        email,
        password,
        username,
      );
      return user.copyWith(
        email: email,
        password: password,
        username: auth.currentUser?.displayName,
      );
    } on FirebaseAuthException catch (e) {
      error.value = firebaseErrorTracker(e);
    } catch (e) {
      error.value = e.toString();
    }
  }

// Firebase  processing is done here
  Future<void> createUserWithEmail(
    String email,
    String password,
    String username,
  ) async {
    await auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    updateUsername(
      username: username,
    );
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

  Future<dynamic> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user.copyWith(
        email: email,
        password: password,
        username: auth.currentUser?.displayName,
      );
    } on FirebaseAuthException catch (e) {
      error.value = firebaseLoginErrorTracker(e);
    } catch (e) {
      error.value = e.toString();
    }
  }

  UserResponseModel currentUser() {
    return user.copyWith(
      email: auth.currentUser?.email,
      username: auth.currentUser?.displayName,
    );
  }

  Future<void> logOut() async {
    await auth.signOut();
  }
}
