import 'package:flutter/material.dart';

extension AddSpacing on List<Widget> {
  List<Widget> separator(Widget separator) {
    List<Widget> cs = [];

    if (isEmpty) return cs;

    for (var child in this) {
      cs.add(child);
      cs.add(separator);
    }
    cs.removeLast();

    return cs;
  }
}

extension Weave<T> on List<T> {
  List<T> separator(T separator) {
    List<T> cs = [];

    if (isEmpty) return cs;

    for (var child in this) {
      cs.add(child);
      cs.add(separator);
    }
    cs.removeLast();

    return cs;
  }
}


