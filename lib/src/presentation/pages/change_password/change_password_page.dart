import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/presentation/pages/global/templates/blue_expanded_button.dart';
import 'package:news360/src/presentation/pages/global/templates/export.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

import 'controller/change_password_controller.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
        child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () => Get.back(),
              icon: const Icon(EvaIcons.arrowBack),
            ),
            AutoSizeText(
              'Change Password',
              style: context.h5.copyWith(
                color: AppColors.blackPrimary,
              ),
            ),
            const SizedBox(
              width: 25,
            ),
          ],
        ),
        const Space.semiBig(),
        Padding(
          padding:  context.spacing().insets.horizontal.semiSmall,
          child: Form(
            child: Column(
              children: [
                Obx(
                  () => FieldWithFocusConfig(
                    controller: controller,
                    prefix: Icons.lock_outline,
                    hintText: 'Current Password',
                    isFocus: controller.currentPasswordIsFocus.value,
                    focusNode: controller.currentPasswordFocusNode,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                const Space.normal(),
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
        ),
      ],
    ));
  }
}
