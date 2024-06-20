import 'package:flutter/material.dart';
import 'package:semper_web/widgets/spacing/spacing.dart';

extension AddSpacing on List<Widget> {

  List<Widget> spacing(double spacing) {
    List<Widget> cs = [];

    if(isEmpty) return cs;

    for (var child in this) {
      cs.add(child);
      cs.add(Spacing(spacing));
    }
    cs.removeLast();

    return cs;
  }

}
