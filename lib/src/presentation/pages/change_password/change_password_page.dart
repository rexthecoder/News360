/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spaces/spaces.dart';

import '../../templates/export.dart';
import '../../theme/theme.dart';
import 'controller/change_password_controller.dart';

class ChangePasswordPage extends GetView<ChangePasswordController> {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: _ChangePasswordBody(
        controller: controller,
      ),
    );
  }
}

class _ChangePasswordBody extends StatelessWidget {
  const _ChangePasswordBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ChangePasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          padding: context.spacing().insets.horizontal.semiSmall,
          child: _ChangePasswordForm(
            controller: controller,
          ),
        ),
      ],
    );
  }
}

class _ChangePasswordForm extends StatelessWidget {
  const _ChangePasswordForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ChangePasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
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
    );
  }
}
