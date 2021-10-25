/*
 *  Copyright (c) 2021, Rexford Asamoah Agyapong 
 * Use of this source code is governed by an MIT-style 
 * license that can be found in the LICENSE file or at 
 * https://opensource.org/licenses/MIT.
 *
 */

import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:news360/src/presentation/theme/theme.dart';

class FieldWithFocusConfig extends StatelessWidget {
  const FieldWithFocusConfig({
    Key? key,
    required this.controller,
    required this.focusNode,
    this.keyboardType,
    this.hintText,
    this.fieldController,
    required this.prefix,
    required this.isFocus,
    this.suffix,
    this.validator,
    this.onSaved,
    this.textInputAction,
    this.obscureText,
  }) : super(key: key);

  final dynamic controller;
  final FocusNode focusNode;
  final TextInputType? keyboardType;
  final String? hintText;
  final IconData prefix;
  final String isFocus;
  final Widget? suffix;
  final String? Function(String?)? validator;
  final TextEditingController? fieldController;
  final void Function(String?)? onSaved;
  final TextInputAction? textInputAction;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      focusNode: focusNode,
      keyboardAppearance: Brightness.dark,
      validator: validator,
      controller: fieldController,
      onSaved: onSaved,
      keyboardType: keyboardType,
      enableSuggestions: true,
      textInputAction: textInputAction ?? TextInputAction.next,
      style: context.bodyText1.copyWith(color: AppColors.blackPrimary),
      cursorColor: AppColors.purplePrimary,
      decoration: InputDecoration(
        errorMaxLines: 1,
        errorText: null,
        filled: true,
        hintText: hintText,
        hintStyle: context.bodyText1.copyWith(color: AppColors.greyPrimary),
        suffixIcon: suffix,
        prefixIcon: Icon(
          prefix,
          size: 22,
          color: isFocus == "true"
              ? AppColors.purplePrimary
              : AppColors.greyPrimary,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.purplePrimary, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        fillColor: isFocus == "true" ? AppColors.white : AppColors.greyLighter,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLighter),
          borderRadius: BorderRadius.circular(15),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyLighter),
          borderRadius: BorderRadius.circular(15),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
