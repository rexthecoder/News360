import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class ForgetPasswordController extends GetxController with UiLoggy {
  //Node fo our textfields
  final FocusNode _emailFocusNode = FocusNode();
  // Node init
  RxString emailIsFocus = 'false'.obs;

  // Tracking Nodes state
  void _onFocusChange() {
    emailIsFocus(_emailFocusNode.hasFocus.toString());
    logDebug("Email Focus: " + _emailFocusNode.hasFocus.toString());
  }

  //Controller getters
  FocusNode get emailFocusNode => _emailFocusNode;
  void get onfocusChange => _onFocusChange();

  @override
  void onReady() {
    _emailFocusNode.addListener(_onFocusChange);
    super.onReady();
  }
}
