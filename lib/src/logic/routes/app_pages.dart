import 'package:get/get.dart';
import 'package:news360/src/presentation/pages/article/controller/article_controller.dart';
import 'package:news360/src/presentation/pages/categoriesmore/controller/category_more_controller.dart';
import 'package:news360/src/presentation/pages/change_password/controller/change_password_controller.dart';
import 'package:news360/src/presentation/pages/homepage/controller/home_controller.dart';
import 'package:news360/src/presentation/pages/homepage/controller/profile_controller.dart';
import 'package:news360/src/presentation/pages/language/controller/lanaguage_controller.dart';
import 'package:news360/src/presentation/pages/login/controller/login_controller.dart';
import 'package:news360/src/presentation/pages/pages.dart';

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
        binding: BindingsBuilder(() {
          Get.lazyPut<LoginController>(() => LoginController());
        })),
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
      transition: Transition.leftToRightWithFade,
      page: () => const RegisterPage(),
    ),
    GetPage(
      transition: Transition.upToDown,
      name: Routes.favorite,
      page: () => const FavoritePage(),
    ),
    GetPage(
        transition: Transition.upToDown,
        name: Routes.home,
        page: () => const HomePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ProfileController>(() => ProfileController());
          Get.lazyPut<HomeController>(() => HomeController());
        })),
    GetPage(
        name: Routes.language,
        page: () => const LanguagePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<LanguageController>(() => LanguageController());
        })),
    GetPage(
      name: Routes.changePassword,
      page: (() => const ChangePasswordPage()),
      binding: BindingsBuilder(() {
        Get.lazyPut<ChangePasswordController>(() => ChangePasswordController());
      }),
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
        page: () => const ArticlePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<ArticleController>(() => ArticleController());
        })),
    GetPage(name: Routes.more, page: () => const MorePage()),
    GetPage(
        name: Routes.categorymore,
        page: () => const CategoryMorePage(),
        binding: BindingsBuilder(() {
          Get.lazyPut<CategoryMoreController>(() => CategoryMoreController());
        }))
  ];
}
