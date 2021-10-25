import 'package:awesome_flutter_extensions/all.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:get/get_utils/src/extensions/context_extensions.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:news360/src/presentation/theme/theme.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: FloatingSearchBar(
        automaticallyImplyBackButton: false,
        height: 55,
        backgroundColor: AppColors.greyLighter,
        elevation: 0,
        leadingActions: [
          FloatingSearchBarAction(
            showIfOpened: true,
            child: Icon(
              EvaIcons.search,
              size: 22,
              color: AppColors.greyPrimary,
            ),
          ),
        ],
        borderRadius: BorderRadius.circular(15),
        hint: 'Search',
        hintStyle: context.bodyText1.copyWith(
          color: AppColors.greyPrimary,
        ),
        margins: const EdgeInsets.only(top: 100, left: 20, right: 20),
        scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
        transitionDuration: const Duration(milliseconds: 800),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        axisAlignment: context.isPortrait ? 0.0 : -1.0,
        openAxisAlignment: 0.0,
        width: context.isPortrait ? 600 : 500,
        debounceDelay: const Duration(milliseconds: 500),
        onQueryChanged: (query) {
          // Call your model, bloc, controller here.
        },
        // Specify a custom transition to be used for
        // animating between opened and closed stated.
        transition: CircularFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction(
            showIfOpened: false,
            child: CircularButton(
              icon: Icon(
                EvaIcons.micOutline,
                size: 22,
                color: AppColors.greyPrimary,
              ),
              onPressed: () {},
            ),
          ),
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
          ),
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Material(
              color: Colors.white,
              elevation: 4.0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: Colors.accents.map((color) {
                  return Container(height: 112, color: color);
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
