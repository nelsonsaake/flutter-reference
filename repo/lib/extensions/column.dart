import 'package:flutter/widgets.dart';
import 'package:semper_web/extensions/widget_list.dart';

extension ColumnSpacing on Column {
  Column spacing(double spacing) {
    return Column(
      crossAxisAlignment: crossAxisAlignment,
      mainAxisAlignment: mainAxisAlignment,
      mainAxisSize: mainAxisSize,
      textBaseline: textBaseline,
      textDirection: textDirection,
      verticalDirection: verticalDirection,
      children: children.spacing(spacing),
    );
  }
}
