/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spaces/spaces.dart';

import '../../../resources/assets/assets.gen.dart';
import '../../templates/export.dart';
import '../../theme/theme.dart';
import 'components/ripple.dart';
import 'controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: AppWrapper(
        child: _LoginBody(
          controller: controller,
        ),
      ),
    );
  }
}

class _LoginBody extends StatelessWidget {
  const _LoginBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Stack(
        children: [
          _LoginStackHeader(controller: controller),
          controller.showRippleEffect
              ? AnimatedBuilder(
                  animation: controller.rippleAnimation,
                  builder: (_, Widget? child) {
                    return Ripple(
                      radius: controller.rippleAnimation.value,
                    );
                  },
                )
              : const SizedBox.shrink(),
        ],
      ),
    );
  }
}

class _LoginStackHeader extends StatelessWidget {
  const _LoginStackHeader({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.spacing().insets.horizontal.normal,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Space.normal(),
          AutoSizeText(
            'Welcome Back 👋',
            style: context.h5.copyWith(
              color: AppColors.blackPrimary,
            ),
          ),
          const Space.semiSmall(),
          AutoSizeText(
            'I am happy to see you again. You can continue where you left off by logging in',
            style: context.bodyText1.copyWith(
              color: AppColors.greyPrimary,
            ),
          ),
          const Space.semiBig(),
          _LoginForm(
            controller: controller,
          )
        ],
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final LoginController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          Obx(
            () => FieldWithFocusConfig(
              controller: controller,
              fieldController: controller.email,
              onSaved: (value) => controller.userModel.email = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field can't be empty";
                }

                return null;
              },
              focusNode: controller.emailFocusNode,
              hintText: 'Email Address',
              keyboardType: TextInputType.emailAddress,
              prefix: Icons.email_outlined,
              isFocus: controller.emailIsFocus.value,
            ),
          ),
          const Space.normal(),
          Obx(
            () => FieldWithFocusConfig(
              obscureText: controller.isPasswordShown.value ? true : false,
              controller: controller,
              prefix: Icons.lock_outline,
              hintText: 'Password',
              fieldController: controller.password,
              onSaved: (value) => controller.userModel.password = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Field can't be empty";
                }

                return null;
              },
              textInputAction: TextInputAction.done,
              isFocus: controller.passwordIsFocus.value,
              focusNode: controller.passwordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              suffix: GestureDetector(
                onTap: () => controller.updatePasswordVisibility,
                child: controller.isPasswordShown.value
                    ? const Icon(Icons.visibility_off_outlined)
                    : const Icon(Icons.visibility_outlined),
              ),
            ),
          ),
          const Space.small(),
          Align(
            alignment: Alignment.topRight,
            child: GestureDetector(
              onTap: () => Get.toNamed('/forgetPassword'),
              child: AutoSizeText(
                'Forgot Password?',
                style: context.bodyText1.copyWith(
                  color: AppColors.greyPrimary,
                ),
              ),
            ),
          ),
          const Space.normal(),
          BlueExpandedButton(
            label: 'Sign In',
            onPressed: () => controller.loginUser(context),
          ),
          const Space.semiBig(),
          Align(
            alignment: Alignment.center,
            child: AutoSizeText(
              'or',
              style: context.bodyText1.copyWith(
                color: AppColors.greyPrimary,
              ),
            ),
          ),
          const Space.semiBig(),
          ButtonWithPrefix(
            prefix: Assets.images.googleLogo,
            label: 'Sign In with Google',
            onPressed: () {},
          ),
          const Space.normal(),
          ButtonWithPrefix(
            prefix: Assets.images.facebookLogo,
            label: 'Sign In with Facebook',
            onPressed: () {},
          ),
          const SizedBox(
            height: 95,
          ),
          Align(
            alignment: Alignment.center,
            child: GestureDetector(
              onTap: () => Get.toNamed('/register'),
              child: AutoSizeText(
                "Don't have an account? Sign Up",
                style: context.bodyText1.copyWith(
                  color: AppColors.greyPrimary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
