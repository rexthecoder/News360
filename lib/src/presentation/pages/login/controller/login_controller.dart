import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/logic/authentication/auth_configuration.dart';
import 'package:news360/src/logic/model/user_models/user_data_model.dart';

class LoginController extends GetxController
    with SingleGetTickerProviderMixin, UiLoggy {
  //Firebase configuration
  final _authConfiguration = AuthConfiguration();
  final userModel = UserResponseModel();
  //local private varriable
  final _isPasswordShown = true.obs;
  // Animation configuration
  late final AnimationController rippleAnimationController;
  late Animation<double> rippleAnimation;

//Textfield managing
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _email = TextEditingController();

  //Node fo our textfields
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  // Node init
  RxString emailIsFocus = 'false'.obs;
  RxString passwordIsFocus = 'false'.obs;

// Tracking Nodes state
  void _onFocusChange() {
    emailIsFocus(_emailFocusNode.hasFocus.toString());
    logDebug("Email Focus: " + _emailFocusNode.hasFocus.toString());
  }

  void _onPasswordFocusChange() {
    passwordIsFocus(_passwordFocusNode.hasFocus.toString());
    logDebug("Password Focus: " + _passwordFocusNode.hasFocus.toString());
  }

  void _updatePasswordVisibility() {
    isPasswordShown(!_isPasswordShown.value);
  }

  //Controller getters
  FocusNode get emailFocusNode => _emailFocusNode;
  FocusNode get passwordFocusNode => _passwordFocusNode;
  RxBool get isPasswordShown => _isPasswordShown;
  void get onfocusChange => _onFocusChange();
  void get onPasswordFocusChange => _onPasswordFocusChange();
  void get updatePasswordVisibility => _updatePasswordVisibility();
  GlobalKey<FormState> get loginFormKey => _loginFormKey;

  TextEditingController get password => _password;
  TextEditingController get email => _email;
// Getting the current context
  final context = Get.context;

  @override
  void onInit() {
    rippleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    rippleAnimation = Tween<double>(
      begin: window.physicalSize.height,
      end: 0.0,
    ).animate(CurvedAnimation(
      parent: rippleAnimationController,
      curve: Curves.easeIn,
    ));
    rippleAnimationController.forward();
    _emailFocusNode.addListener(_onFocusChange);
    _passwordFocusNode.addListener(_onPasswordFocusChange);
    super.onInit();
  }

  void loginUser(context) {
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      _authConfiguration.loginUser(
        context,
        email: userModel.email!,
        password: userModel.password!,
      );
    }
  }
}
