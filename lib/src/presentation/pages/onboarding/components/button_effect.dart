import 'package:flutter/material.dart';

import 'package:get/get.dart';
import '../../../theme/theme.dart';

class ButtonEffect extends StatefulWidget {
  const ButtonEffect({Key? key}) : super(key: key);

  @override
  _ButtonEffectState createState() => _ButtonEffectState();
}

class _ButtonEffectState extends State<ButtonEffect>
    with TickerProviderStateMixin {
  late AnimationController rippleController;
  late AnimationController scaleController;

  late Animation<double> rippleAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    rippleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    scaleController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 495))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          scaleController.reverse();

          Get.offAndToNamed(
            '/login',
          );
        }
      });
    rippleAnimation =
        Tween<double>(begin: 80.0, end: 90.0).animate(rippleController)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              rippleController.reverse();
            } else if (status == AnimationStatus.dismissed) {
              rippleController.forward();
            }
          });
    scaleAnimation =
        Tween<double>(begin: 1.0, end: 30.0).animate(scaleController);

    rippleController.forward();
  }

  @override
  void dispose() {
    rippleController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: AnimatedBuilder(
        animation: rippleAnimation,
        builder: (context, child) => SizedBox(
          width: rippleAnimation.value,
          height: rippleAnimation.value,
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: AppColors.purpleLight),
            child: InkWell(
              onTap: () {
                scaleController.forward();
              },
              child: AnimatedBuilder(
                animation: scaleAnimation,
                builder: (context, child) => Transform.scale(
                  scale: scaleAnimation.value,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.purplePrimary),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
