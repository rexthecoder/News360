import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:news360/resources/assets/assets.gen.dart';
import 'package:news360/src/presentation/theme/theme.dart';


class ButtonWithPrefix extends StatelessWidget {
  const ButtonWithPrefix({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.prefix,
  }) : super(key: key);

  final String label;
  final AssetGenImage prefix;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: TextButton(
        // fillColor: AppColors.purplePrimary,
        style: TextButton.styleFrom(
          alignment: Alignment.centerLeft,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: AppColors.greyLighter,
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            prefix.image(),
            Text(
              label,
              textAlign: TextAlign.center,
              style: context.bodyText1.copyWith(color: AppColors.greyDarker),
            ),
            const SizedBox(
              width: 20,
            )
          ],
        ),
        onPressed: onPressed,
      ),
    );
  }
}
