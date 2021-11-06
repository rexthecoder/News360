import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

import '../../../../logic/authentication/authentication_controller.dart';
import '../../../../logic/authentication/authentication_state.dart';
import '../../../../logic/model/user_models/user_data_model.dart';

class RegisterController extends GetxController with UiLoggy {
  //Firebase configuration
  final userModel = UserResponseModel();
  final AuthenticationController _authenticationController = Get.find();
  //Textfield managing
  final GlobalKey<FormState> _registerFormKey = GlobalKey<FormState>();
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

  //Node fo our textfields
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repeatPasswordFocusNode = FocusNode();
  final FocusNode _userNameFocusNode = FocusNode();

  // Node init
  RxString emailIsFocus = 'false'.obs;
  RxString passwordIsFocus = 'false'.obs;
  RxString repeatPasswordIsFocus = 'false'.obs;
  RxString userNameIsFocus = 'false'.obs;

// Tracking Nodes state
  void _onFocusChange() {
    emailIsFocus(_emailFocusNode.hasFocus.toString());
    logDebug("Email Focus: " + _emailFocusNode.hasFocus.toString());
  }

  void _onPasswordFocusChange() {
    passwordIsFocus(_passwordFocusNode.hasFocus.toString());
    logDebug("Password Focus: " + _passwordFocusNode.hasFocus.toString());
  }

  void _onRepeatPasswordFocusChange() {
    repeatPasswordIsFocus(_repeatPasswordFocusNode.hasFocus.toString());
    logDebug("Password Focus: " + repeatPasswordFocusNode.hasFocus.toString());
  }

  void _usernameFocusChange() {
    userNameIsFocus(_userNameFocusNode.hasFocus.toString());
  }

// Function with side effect. Validate and register user at the same time
  Future<void> registerUser(context) async {
    if (_registerFormKey.currentState!.validate()) {
      _registerFormKey.currentState!.save();
      EasyLoading.show(status: 'Loading...');
      await _authenticationController.signUp(
        email: userModel.email!,
        password: userModel.password!,
        username: userModel.username!,
      );
      signUpConfiguration();
    }
  }

  void signUpConfiguration() {
    if (_authenticationController.state is AuthenticatedFailure) {
      EasyLoading.dismiss();
      final error =
          (_authenticationController.state as AuthenticatedFailure).message;

      EasyLoading.showToast(error);
    }
    if (_authenticationController.state is Authenticated) {
      EasyLoading.dismiss();
      Get.toNamed('favorite');
    }
  }

  //Controller getters
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
  FocusNode get repeatPasswordFocusNode => _repeatPasswordFocusNode;
  FocusNode get userNameFocusNode => _userNameFocusNode;
  GlobalKey<FormState> get registerFormKey => _registerFormKey;
  TextEditingController get username => _username;
  TextEditingController get password => _password;
  TextEditingController get email => _email;
  void get onfocusChange => _onFocusChange();
  void get onPasswordFocusChange => _onPasswordFocusChange();

  @override
  void onInit() {
    _emailFocusNode.addListener(_onFocusChange);
    _userNameFocusNode.addListener(_usernameFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
    _repeatPasswordFocusNode.addListener(_onRepeatPasswordFocusChange);
    _userNameFocusNode.addListener(_usernameFocusChange);
    super.onInit();
  }
}
