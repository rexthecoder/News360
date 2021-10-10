import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news360/src/presentation/theme/theme.dart';

class AppWrapper extends StatelessWidget {
  const AppWrapper({
    Key? key,
    required this.child,
    this.bottomNavigationBar,
  }) : super(key: key);

  final Widget child;
  final Widget? bottomNavigationBar;

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: mySystemTheme,
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
