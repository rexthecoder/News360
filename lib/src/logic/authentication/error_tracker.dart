import 'package:firebase_auth/firebase_auth.dart';

mixin ErrorTracker {
  String firebaseErrorTracker(
    FirebaseAuthException e,
  ) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for this email';
    } else {
      return '$e';
    }
  }

  String firebaseLoginErrorTracker(
    FirebaseAuthException e,
  ) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    } else {
      return '$e';
    }
  }
}
