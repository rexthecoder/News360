import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/presentation/pages/global/templates/widget_wrapper.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

class BookmarkPage extends GetView {
  const BookmarkPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
        child: Padding(
      padding: context.spacing().insets.horizontal.normal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Space.normal(),
              AutoSizeText(
                'Bookmarks',
                style: context.h5.copyWith(
                  color: AppColors.blackPrimary,
                ),
              ),
              const Space.semiSmall(),
              AutoSizeText(
                'Saved articles to the library',
                style: context.bodyText1.copyWith(
                  color: AppColors.greyPrimary,
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  maxRadius: 40,
                  backgroundColor: AppColors.purplePrimary.withOpacity(0.1),
                  child: Icon(EvaIcons.bookOutline, color: AppColors.purpleDarker,),
                ),
                         const Space.semiSmall(),
                AutoSizeText(
                  "You haven't saved any articles\nyet. Start reading and\nbookmarking them now",
                  textAlign: TextAlign.center,
                  style: context.h6.copyWith(
                    color: AppColors.blackPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          )
        ],
      ),
    ));
  }
}
