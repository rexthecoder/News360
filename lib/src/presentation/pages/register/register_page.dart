import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/presentation/pages/global/templates/blue_expanded_button.dart';
import 'package:news360/src/presentation/pages/global/templates/export.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

import 'controller/register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    RegisterController _ = Get.put(RegisterController());
    return AppWrapper(
      child: SizedBox(
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
              Form(
                child: Column(
                  children: [
                    Obx(
                      () => FieldWithFocusConfig(
                        controller: controller,
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
                        hintText: 'Repeat Password',
                        isFocus: controller.repeatPasswordIsFocus.value,
                        focusNode: controller.repeatPasswordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    const Space.normal(),
                    BlueExpandedButton(
                      label: 'Sign Up',
                      onPressed: () => Get.toNamed('/verify'),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                  onTap: () => Get.toNamed('/login'),
                  child: AutoSizeText(
                    "Already have an account? Sign In",
                    style: context.bodyText1.copyWith(
                      color: AppColors.greyPrimary,
                    ),
                  ),
                ),
              ),
              const Space.normal()
            ],
          ),
        ),
      ),
    );
  }
}
