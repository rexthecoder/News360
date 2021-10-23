import 'package:auto_size_text_pk/auto_size_text_pk.dart';
import 'package:awesome_flutter_extensions/all.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news360/src/logic/global/categories.dart';
import 'package:news360/src/logic/global/variables.dart';
import 'package:news360/src/presentation/pages/global/templates/export.dart';
import 'package:news360/src/presentation/theme/theme.dart';
import 'package:spaces/spaces.dart';

class CategoriesPage extends GetView {
  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppWrapper(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: context.spacing().insets.horizontal.normal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              const Space.normal(),
              AutoSizeText(
                'Categories',
                style: context.h5.copyWith(
                  color: isDarkMode ? AppColors.white : AppColors.blackPrimary,
                ),
              ),
              const Space.semiSmall(),
              AutoSizeText(
                'Thousands of articles in each category',
                style: context.bodyText1.copyWith(
                  color: AppColors.greyPrimary,
                ),
              ),
              const Space.semiBig(),
              SizedBox(
                child: GridView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed('/categorymore',
                            arguments: categoriesList[index]);
                      },
                      child: SizedBox(
                        width: 160,
                        height: 78,
                        child: Card(
                          elevation: 0,
                          color: AppColors.white,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: AppColors.greyLighter,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: AutoSizeText(
                              categories[index],
                              style: context.bodyText1.copyWith(
                                color: AppColors.greyDarker,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: categories.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 1.8,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
