/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

class NewPasswordController extends GetxController with UiLoggy {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _repeatPasswordFocusNode = FocusNode();

  RxString passwordIsFocus = 'false'.obs;
  RxString repeatPasswordIsFocus = 'false'.obs;

  FocusNode get passwordFocusNode => _passwordFocusNode;
  FocusNode get repeatPasswordFocusNode => _repeatPasswordFocusNode;

  void _onPasswordFocusChange() {
    passwordIsFocus(_passwordFocusNode.hasFocus.toString());
    logDebug('Password Focus: ' + _passwordFocusNode.hasFocus.toString());
  }

  void _onRepeatPasswordFocusChange() {
    repeatPasswordIsFocus(_repeatPasswordFocusNode.hasFocus.toString());
    logDebug('Password Focus: ' + repeatPasswordFocusNode.hasFocus.toString());
  }

  @override
  void onInit() {
    _passwordFocusNode.addListener(_onPasswordFocusChange);
    _repeatPasswordFocusNode.addListener(_onRepeatPasswordFocusChange);
    super.onInit();
  }
}
