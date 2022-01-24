import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spaces/spaces.dart';

import '../../templates/export.dart';
import '../../theme/theme.dart';
import 'controller/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterController _ = Get.put(RegisterController());
    return AppWrapper(
      child: _RegisterBody(controller: controller),
    );
  }
}

class _RegisterBody extends StatelessWidget {
  const _RegisterBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: context.spacing().insets.horizontal.normal,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Space.normal(),
            AutoSizeText(
              'Welcome to News360 👋',
              style: context.h5.copyWith(
                color: AppColors.blackPrimary,
              ),
            ),
            const Space.semiSmall(),
            AutoSizeText(
              'Hello, I guess you are new around here. You can start using the application after sign up.',
              style: context.bodyText1.copyWith(
                color: AppColors.greyPrimary,
              ),
            ),
            const Space.semiBig(),
            _RegisterForm(
              controller: controller,
            ),
            const Spacer(),
            Align(
              alignment: Alignment.center,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: AutoSizeText(
                  'Already have an account? Sign In',
                  style: context.bodyText1.copyWith(
                    color: AppColors.greyPrimary,
                  ),
                ),
              ),
            ),
            const Space.big()
          ],
        ),
      ),
    );
  }
}

class _RegisterForm extends StatelessWidget {
  const _RegisterForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final RegisterController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.registerFormKey,
      child: Column(
        children: [
          Obx(
            () => FieldWithFocusConfig(
              fieldController: controller.username,
              controller: controller,
              onSaved: (value) => controller.userModel.username = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill in the field';
                }
                return null;
              },
              focusNode: controller.userNameFocusNode,
              hintText: 'Username',
              keyboardType: TextInputType.name,
              prefix: Icons.person_outlined,
              isFocus: controller.userNameIsFocus.value,
            ),
          ),
          const Space.normal(),
          Obx(
            () => FieldWithFocusConfig(
              controller: controller,
              focusNode: controller.emailFocusNode,
              hintText: 'Email Address',
              fieldController: controller.email,
              onSaved: (value) => controller.userModel.email = value,
              validator: (value) {
                if (!value!.contains('@gmail.com')) {
                  return 'Email can be only be gmail';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
              prefix: Icons.email_outlined,
              isFocus: controller.emailIsFocus.value,
            ),
          ),
          const Space.normal(),
          Obx(
            () => FieldWithFocusConfig(
              controller: controller,
              prefix: Icons.lock_outline,
              fieldController: controller.password,
              onSaved: (value) => controller.userModel.password = value,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Fill in the field';
                }
                if (value.length <= 5) {
                  return 'Password has to be more than 5';
                }
                return null;
              },
              hintText: 'Password',
              isFocus: controller.passwordIsFocus.value,
              focusNode: controller.passwordFocusNode,
              keyboardType: TextInputType.visiblePassword,
            ),
          ),
          const Space.normal(),
          Obx(
            () => FieldWithFocusConfig(
              controller: controller,
              prefix: Icons.lock_outline,
              validator: (value) {
                if (value != controller.password.text) {
                  return 'Confirm the password';
                }
                return null;
              },
              hintText: 'Repeat Password',
              isFocus: controller.repeatPasswordIsFocus.value,
              focusNode: controller.repeatPasswordFocusNode,
              keyboardType: TextInputType.visiblePassword,
              textInputAction: TextInputAction.done,
            ),
          ),
          const Space.normal(),
          BlueExpandedButton(
            label: 'Sign Up',
            onPressed: () => controller.registerUser(context),
          ),
        ],
      ),
    );
  }
}
