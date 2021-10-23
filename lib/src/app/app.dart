import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:news360/src/localization/localization_services.dart';
import 'package:news360/src/logic/authentication/authentication_controller.dart';
import 'package:news360/src/logic/authentication/authentication_state.dart';
import 'package:news360/src/logic/global/variables.dart';
import 'package:news360/src/presentation/theme/app_theme.dart';

import 'package:spaces/spaces.dart';

import '../logic/routes/app_pages.dart';
import '../presentation/theme/app_theme.dart';

/// The Widget that configures your application.
class App extends GetWidget<AuthenticationController> {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    appdata.writeIfNull('darkmode', false);
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return SimpleBuilder(
      builder: (_) {
        isDarkMode = appdata.read('darkmode');
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDarkMode ? darkSystemTheme : systemTheme,
          child: GetMaterialApp(
            title: 'title'.tr,

            debugShowCheckedModeBanner: false,
            initialRoute: controller.state is UnAuthenticated
                ? Routes.onBoarding
                : controller.state is Authenticated
                    ? Routes.home
                    : Routes.onBoarding,

            defaultTransition: Transition.leftToRight,
            showPerformanceOverlay: false,
            // home: TestingScreen(),
            builder: (context, child) => Spacing(
              dataBuilder: (context) {
                final mediaQuery = MediaQuery.of(context);
                return SpacingData.generate(
                  mediaQuery.size.width > 300.0 ? 20.0 : 10.0,
                );
              },
              child: child!,
            ),
            getPages: AppPages.pages,
            locale: LocalizationService.locale,
            fallbackLocale: LocalizationService.fallbackLocale,
            translations: LocalizationService(),

            theme: isDarkMode ? darkTheme : lightTheme,
          ),
        );
      },
    );
  }
}
