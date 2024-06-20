import 'package:flutter/widgets.dart';
import 'package:semper_web/extensions/widget_list.dart';

extension RowSpacing on Row {
  Row spacing(double spacing) {
    return Row(
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
