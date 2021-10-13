import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

mixin ErrorTracker {
  void firebaseErrorTracker(
    FirebaseAuthException e,
    context,
    String email,
    progress,
  ) {
    if (e.code == 'weak-password') {
      progress?.dismiss();
      showToast(
        "The password provided is too weak.",
        context: context,
      );
    } else if (e.code == 'email-already-in-use') {
      progress?.dismiss();

      showToast(
        "The account already exists for $email",
        context: context,
      );
    }
  }
}
