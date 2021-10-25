// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'fancy_bottom_item.dart';
import 'fancy_item.dart';

export 'fancy_bottom_bar.dart';
export 'fancy_bottom_item.dart';

const double DEFAULT_BOTTOM_APP_BAR_HEIGHT = 64;
const double DEFAULT_ELEVATION = 8;

class FancyBottomBar extends StatelessWidget {
  final ValueChanged<int>? onItemSelected;
  final int? selectedPosition;
  final List<FancyBottomItem>? items;
  final double? height;
  final double? elevation;
  final Color? bgColor;
  final Color? indicatorColor;
  final Color? selectedColor;

  FancyBottomBar({
    Key? key,
    this.onItemSelected,
    this.selectedPosition,
    this.items,
    this.height,
    this.elevation,
    this.bgColor,
    this.indicatorColor,
    this.selectedColor,
  })  : assert(items!.isNotEmpty),
        assert(selectedPosition != null),
        assert(selectedPosition! >= 0 && selectedPosition < items!.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      
      elevation: elevation ?? DEFAULT_ELEVATION,
      color: bgColor ?? Theme.of(context).bottomAppBarColor,
      child: SizedBox(
        child: Row(
          children: items!
              .asMap()
              .map((i, item) => MapEntry(
                  i,
                  Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () => onItemSelected!(i),
                      child: FancyItem(
                        item: item,
                        selected: i == selectedPosition,
                        indicatorColor: indicatorColor,
                        selectedColor: selectedColor,
                      ),
                    ),
                  )))
              .values
              .toList(),
        ),
        height: height ?? DEFAULT_BOTTOM_APP_BAR_HEIGHT,
      ),
    );
  }
}
