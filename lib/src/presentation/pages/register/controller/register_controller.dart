import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class RegisterController extends GetxController with UiLoggy {
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

  //Controller getters
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
  FocusNode get repeatPasswordFocusNode => _repeatPasswordFocusNode;
  FocusNode get userNameFocusNode => _userNameFocusNode;
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
