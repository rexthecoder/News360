// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

import 'fancy_bottom_bar.dart';
import 'tap_ring.dart';

const Duration ANIM_DURATION = Duration(milliseconds: 400);
const double ANIM_Y_OFFSET = -200;
const double SELECTION_INDICATOR_SIZE = 4;

class FancyItem extends StatefulWidget {
  final FancyBottomItem item;
  final bool? selected;
  final Color? indicatorColor;
  final Color? selectedColor;

  const FancyItem({
    Key? key,
    required this.item,
    this.selected,
    this.indicatorColor,
    this.selectedColor,
  }) : super(key: key);

  @override
  _FancyItemState createState() => _FancyItemState();
}

class _FancyItemState extends State<FancyItem> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final selectedIndicator = Container(
      width: SELECTION_INDICATOR_SIZE,
      height: SELECTION_INDICATOR_SIZE,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: widget.indicatorColor ?? Colors.black,
      ),
    );
    final title = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Spacer(flex: 4),
        widget.item.title,
        const Spacer(flex: 2),
        selectedIndicator,
        const Spacer(flex: 1),
      ],
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          // overflow: Overflow.clip,
          alignment: Alignment.center,
          children: <Widget>[
            AnimatedPositioned(
              child: title,
              duration: ANIM_DURATION,
              top: 0,
              bottom: widget.selected! ? 0 : ANIM_Y_OFFSET,
            ),
            AnimatedPositioned(
              child: widget.item.icon,
              duration: ANIM_DURATION,
              top: widget.selected! ? ANIM_Y_OFFSET : 0,
              bottom: 0,
            ),
            Positioned.fill(
              child: Center(
                child: TapRing(
                  isSelected: widget.selected!,
                  color: widget.selectedColor ?? Theme.of(context).secondaryHeaderColor,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
