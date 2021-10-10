import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/presentation/pages/global/templates/blue_expanded_button.dart';
import 'package:news360/src/presentation/pages/global/templates/export.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

import 'controller/new_password_controller.dart';

class NewPasswordPage extends GetView<NewPasswordController> {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewPasswordController _ = Get.put(NewPasswordController());
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
                'Create New Password 🔒',
                style: context.h5.copyWith(
                  color: AppColors.blackPrimary,
                ),
              ),
              const Space.semiSmall(),
              AutoSizeText(
                'You can create a new password, please dont forget it too.',
                style: context.bodyText1.copyWith(
                  color: AppColors.greyPrimary,
                ),
              ),
              const Space.semiBig(),
              Form(
                child: Column(
                  children: [
                    // Obx(
                    //   () => FieldWithFocusConfig(
                    //     controller: controller,
                    //     focusNode: controller.emailFocusNode,
                    //     hintText: 'Email Address',
                    //     keyboardType: TextInputType.emailAddress,
                    //     prefix: Icons.email_outlined,
                    //     isFocus: controller.emailIsFocus.value,
                    //   ),
                    // ),
                    Obx(
                      () => FieldWithFocusConfig(
                        controller: controller,
                        prefix: Icons.lock_outline,
                        hintText: 'New Password',
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
                        hintText: 'Repeat New Password',
                        isFocus: controller.repeatPasswordIsFocus.value,
                        focusNode: controller.repeatPasswordFocusNode,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    const Space.normal(),
                    BlueExpandedButton(
                      label: 'Confirm',
                      onPressed: () => Get.toNamed('/verify'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
