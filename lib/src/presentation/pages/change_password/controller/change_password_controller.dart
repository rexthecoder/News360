import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class ChangePasswordController extends GetxController with UiLoggy {
  final FocusNode _currentPasswordFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repeatPasswordFocusNode = FocusNode();

  RxString passwordIsFocus = 'false'.obs;
  RxString repeatPasswordIsFocus = 'false'.obs;
  RxString currentPasswordIsFocus = 'false'.obs;

  FocusNode get passwordFocusNode => _passwordFocusNode;
  FocusNode get repeatPasswordFocusNode => _repeatPasswordFocusNode;
  FocusNode get currentPasswordFocusNode => _currentPasswordFocusNode;

  void _currentPasswordFocusChange() {
     currentPasswordIsFocus(_currentPasswordFocusNode.hasFocus.toString());
   
    logDebug("Password Focus: " + _passwordFocusNode.hasFocus.toString());
  }

  void _onPasswordFocusChange() {
    passwordIsFocus(_passwordFocusNode.hasFocus.toString());
    logDebug(
        "Password Focus: " + _currentPasswordFocusNode.hasFocus.toString());
  }

  void _onRepeatPasswordFocusChange() {
    repeatPasswordIsFocus(_repeatPasswordFocusNode.hasFocus.toString());
    logDebug("Password Focus: " + repeatPasswordFocusNode.hasFocus.toString());
  }

  @override
  void onInit() {
    _currentPasswordFocusNode.addListener(_currentPasswordFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
    _repeatPasswordFocusNode.addListener(_onRepeatPasswordFocusChange);
    super.onInit();
  }
}
