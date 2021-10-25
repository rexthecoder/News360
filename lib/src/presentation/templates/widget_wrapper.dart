import 'package:flutter/material.dart';
import 'package:flutter_focus_watcher/flutter_focus_watcher.dart';

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
    return FocusWatcher(
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: false,
        // backgroundColor:
        //     isDarkMode ? AppColors.blackPrimary : AppColors.white,
        body: SafeArea(
          child: child,
        ),
      ),
    );
  }
}
