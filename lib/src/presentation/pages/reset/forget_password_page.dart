import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spaces/spaces.dart';

import '../../templates/export.dart';
import '../../theme/theme.dart';
import 'controller/forget_password_controller.dart';

class ForgetPasswordPage extends GetView<ForgetPasswordController> {
  const ForgetPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ForgetPasswordController controller = Get.put(ForgetPasswordController());
    return AppWrapper(
      child: _ForgetPasswordBody(
        controller: controller,
      ),
    );
  }
}

class _ForgetPasswordBody extends StatelessWidget {
  const _ForgetPasswordBody({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ForgetPasswordController controller;

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
              'Forgot Password 🤔',
              style: context.h5.copyWith(
                color: AppColors.blackPrimary,
              ),
            ),
            const Space.semiSmall(),
            AutoSizeText(
              'We need your email adress so we can send you the password reset code.',
              style: context.bodyText1.copyWith(
                color: AppColors.greyPrimary,
              ),
            ),
            const Space.semiBig(),
            _ForgetPasswordForm(controller: controller),
          ],
        ),
      ),
    );
  }
}

class _ForgetPasswordForm extends StatelessWidget {
  const _ForgetPasswordForm({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final ForgetPasswordController controller;

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
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
          BlueExpandedButton(
            label: 'Next',
            onPressed: () => Get.toNamed('/verify'),
          ),
        ],
      ),
    );
  }
}
