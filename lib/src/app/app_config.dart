/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:news360/src/localization/localization_services.dart';
import 'package:news360/src/logic/authentication/export.dart';
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
    // System display configuration
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // setting the mode incase this is the first time user is using the app
    appdata.writeIfNull('darkmode', false);

    return SimpleBuilder(
      builder: (_) {
        isDarkMode = appdata.read('darkmode');
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: isDarkMode ? darkSystemTheme : systemTheme,
          child: GetMaterialApp(
            title: 'title'.tr,
            debugShowCheckedModeBanner: false,
            initialRoute: initialRoute(
              state: controller.state,
            ),
            defaultTransition: Transition.leftToRight,
            builder: EasyLoading.init(
              builder: (context, child) => _SpacesWidget(
                child: child!,
              ),
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

class _SpacesWidget extends StatelessWidget {
  const _SpacesWidget({Key? key, required this.child}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Spacing(
      dataBuilder: (context) {
        final mediaQuery = MediaQuery.of(context);
        return SpacingData.generate(
          mediaQuery.size.width > 300.0 ? 20.0 : 10.0,
        );
      },
      child: child,
    );
  }
}

//maintain the routing base on the  ccurrent auth state
String initialRoute({required state}) {
  if (state is UnAuthenticated) return Routes.onBoarding;
  if (state is Authenticated) return Routes.home;
  return Routes.onBoarding;
}
