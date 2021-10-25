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
import 'package:news360/src/presentation/templates/export.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

import 'controller/new_password_controller.dart';

class NewPasswordPage extends GetView<NewPasswordController> {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    NewPasswordController _ = Get.put(NewPasswordController());
    return AppWrapper(
      child: _NewPasswordBody(
        controller: controller,
      ),
    );
  }
}

class _NewPasswordBody extends StatelessWidget {
  const _NewPasswordBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final NewPasswordController controller;

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
            _NewPasswordPageForm(
              controller: controller,
            ),
          ],
        ),
      ),
    );
  }
}

class _NewPasswordPageForm extends StatelessWidget {
  const _NewPasswordPageForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final NewPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
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
    );
  }
}
