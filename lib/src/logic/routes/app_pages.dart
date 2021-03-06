/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:get/get.dart';

import '../../presentation/pages/onboarding/onboarding.dart';
import '../../presentation/pages/pages.dart';

part './app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.onBoarding,
      page: () => OnBoardingPage(),
    ),
    GetPage(
      name: Routes.login,
      transition: Transition.noTransition,
      page: () => const LoginPage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<LoginController>(() => LoginController());
        },
      ),
    ),
    GetPage(
      name: Routes.forgetPassword,
      page: () => const ForgetPasswordPage(),
    ),
    GetPage(
      name: Routes.verify,
      page: () => const VerifyPage(),
    ),
    GetPage(
      name: Routes.newpassword,
      page: () => const NewPasswordPage(),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterPage(),
    ),
    GetPage(
      name: Routes.favorite,
      page: () => const FavoritePage(),
    ),
    GetPage(
      name: Routes.home,
      page: () => const HomePage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<ProfileController>(
            () => ProfileController(),
          );
          Get.lazyPut<HomeController>(
            () => HomeController(),
          );
        },
      ),
    ),
    GetPage(
      name: Routes.language,
      page: () => const LanguagePage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<LanguageController>(
            () => LanguageController(),
          );
        },
      ),
    ),
    GetPage(
      name: Routes.changePassword,
      page: (() => const ChangePasswordPage()),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<ChangePasswordController>(
            () => ChangePasswordController(),
          );
        },
      ),
    ),
    GetPage(
      name: Routes.terms,
      page: () => const TermsAndConditionPage(),
    ),
    GetPage(
      name: Routes.privacy,
      page: () => const PrivacyPage(),
    ),
    GetPage(
      name: Routes.article,
      transition: Transition.noTransition,
      page: () => const ArticlePage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<ArticleController>(
            () => ArticleController(),
          );
        },
      ),
    ),
    GetPage(
      name: Routes.more,
      page: () => const MorePage(),
    ),
    GetPage(
      name: Routes.categorymore,
      page: () => const CategoryMorePage(),
      binding: BindingsBuilder(
        () {
          Get.lazyPut<CategoryMoreController>(() => CategoryMoreController());
        },
      ),
    )
  ];
}
