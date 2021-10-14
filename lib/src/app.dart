import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'package:spaces/spaces.dart';

import 'logic/routes/app_pages.dart';
import 'presentation/theme/app_theme.dart';
import 'settings/settings_controller.dart';

//Theme
final _lightTheme = AppTheme.lightTheme();

/// The Widget that configures your application.
class App extends StatelessWidget {
  const App({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Glue the SettingsController to the MaterialApp.
    //
    // The AnimatedBuilder Widget listens to the SettingsController for changes.
    // Whenever the user updates their settings, the MaterialApp is rebuilt.
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: Routes.onBoarding,
          theme: _lightTheme,
          defaultTransition: Transition.fade,
          // showPerformanceOverlay: true,
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

          // Provide the generated AppLocalizations to the MaterialApp. This
          // allows descendant Widgets to display the correct translations
          // depending on the user's locale.
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],

          // Use AppLocalizations to configure the correct application title
          // depending on the user's locale.
          //
          // The appTitle is defined in .arb files found in the localization
          // directory.
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,

          // Define a light and dark color theme. Then, read the user's
          // preferred ThemeMode (light, dark, or system default) from the
          // SettingsController to display the correct theme.

          darkTheme: ThemeData.light(),
          themeMode: settingsController.themeMode,
        );
      },
    );
  }
}
