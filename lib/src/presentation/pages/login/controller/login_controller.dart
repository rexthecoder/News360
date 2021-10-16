import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:news360/src/logic/authentication/authentication_controller.dart';
import 'package:news360/src/logic/authentication/authentication_state.dart';
import 'package:news360/src/logic/model/user_models/user_data_model.dart';

class LoginController extends GetxController
    with SingleGetTickerProviderMixin, UiLoggy {
  //Firebase configuration
  final userModel = UserResponseModel();
  final AuthenticationController _authenticationController = Get.find();

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
  RxBool isOverflow = false.obs;
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

  Future<void> loginUser(
    context,
  ) async {
    final progress = ProgressHUD.of(context);
    if (_loginFormKey.currentState!.validate()) {
      _loginFormKey.currentState!.save();
      progress?.showWithText('Loading...');
      await _authenticationController.signIn(
        email: userModel.email!,
        password: userModel.password!,
      );
      loginConfiguration(context, progress);
    }
  }

  void loginConfiguration(context, progress) {
    if (_authenticationController.state is AuthenticatedFailure) {
      progress?.dismiss();
      final error =
          (_authenticationController.state as AuthenticatedFailure).message;

      showToast(error, context: context);
    }
    if (_authenticationController.state is Authenticated) {
      progress?.dismiss();
      Get.toNamed('/home');
    }
  }
}
