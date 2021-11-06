import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import '../theme/theme.dart';

class BlueExpandedButton extends StatelessWidget {
  const BlueExpandedButton({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  final String label;
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: RawMaterialButton(
        fillColor: AppColors.purplePrimary,
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: context.bodyText1.copyWith(color: AppColors.white),
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        onPressed: onPressed,
      ),
    );
  }
}
