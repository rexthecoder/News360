import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'package:awesome_flutter_extensions/all.dart';
import 'package:news360/resources/assets/assets.gen.dart';
import 'package:news360/src/presentation/pages/global/templates/blue_expanded_button.dart';
import 'package:news360/src/presentation/pages/global/templates/export.dart';
import 'package:news360/src/presentation/pages/global/templates/field_focus_config.dart';
import 'package:news360/src/presentation/pages/global/templates/widget_wrapper.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';
import 'components/ripple.dart';
import 'controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    LoginController controller = Get.put(LoginController());

    return AppWrapper(
      child: SizedBox(
        width: double.infinity,
        child: Stack(
          children: [
            Padding(
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
                  Form(
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
                        Obx(
                          () => FieldWithFocusConfig(
                            controller: controller,
                            prefix: Icons.lock_outline,
                            hintText: 'Password',
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
                             onTap: ()=> Get.toNamed('/forgetPassword'),
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
                          onPressed: () => Get.toNamed('/home'),
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
                        const Space.extraBig(),
                        Align(
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: ()=> Get.toNamed('/register'),
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
                  )
                ],
              ),
            ),
            AnimatedBuilder(
              animation: controller.rippleAnimation,
              builder: (_, Widget? child) {
                return Ripple(radius: controller.rippleAnimation.value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
