import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/presentation/templates/export.dart';
import 'package:news360/src/presentation/theme/app_colors.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:spaces/spaces.dart';

import 'controller/verify_controller.dart';

class VerifyPage extends GetView<VerifyController> {
  const VerifyPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    VerifyController _ = Get.put(VerifyController());
    return const AppWrapper(
      child: _VerifyBody(),
    );
  }
}

class _VerifyBody extends StatelessWidget {
  const _VerifyBody({
    Key? key,
  }) : super(key: key);

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
              'Verification Code ✅',
              style: context.h5.copyWith(
                color: AppColors.blackPrimary,
              ),
            ),
            const Space.semiSmall(),
            AutoSizeText(
              'You need to enter 4-digit code we send to your email adress.',
              style: context.bodyText1.copyWith(
                color: AppColors.greyPrimary,
              ),
            ),
            const Space.semiBig(),
            const _VerifyForm(),
          ],
        ),
      ),
    );
  }
}

class _VerifyForm extends StatelessWidget {
  const _VerifyForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          PinCodeTextField(
            appContext: context,

            length: 4,
            useHapticFeedback: true,
            hapticFeedbackTypes: HapticFeedbackTypes.vibrate,
            obscureText: false,
            animationType: AnimationType.fade,
            cursorColor: AppColors.purplePrimary,
            textStyle:
                context.bodyText1.copyWith(color: AppColors.blackPrimary),
            keyboardType: TextInputType.number,
            hintCharacter: '*',
            hintStyle:
                context.bodyText1.copyWith(color: AppColors.blackPrimary),
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(15),
              fieldHeight: 80,
              borderWidth: 1,
              fieldWidth: 70,
              activeColor: AppColors.greyLighter,
              selectedColor: AppColors.purplePrimary,
              activeFillColor: AppColors.greyLighter,
              selectedFillColor: AppColors.white,
              inactiveColor: AppColors.greyLighter,
              inactiveFillColor: AppColors.greyLighter,
              disabledColor: AppColors.greyLighter,
            ),
            animationDuration: const Duration(milliseconds: 300),
            enableActiveFill: true,
            // errorAnimationController: errorController,
            // controller: textEditingController,
            onCompleted: (v) {},
            onChanged: (value) {
              // print(value);
              // setState(() {
              //   currentText = value;
              // });
            },
            beforeTextPaste: (text) {
              debugPrint("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
              return true;
            },
          ),
          const Space.normal(),
          BlueExpandedButton(
            label: 'Confirm',
            onPressed: () => Get.toNamed('/newPassword'),
          ),
        ],
      ),
    );
  }
}
