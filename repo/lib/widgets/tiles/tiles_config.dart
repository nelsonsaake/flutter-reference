import 'package:flutter/material.dart';

class TilesConfig extends InheritedWidget {
  final double? spacing;
  final int? count;

  const TilesConfig({
    super.key,
    required super.child,
    this.spacing,
    this.count,
  });

  static TilesConfig? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TilesConfig>();
  }

  static TilesConfig of(BuildContext context) {
    final TilesConfig? result = maybeOf(context);
    assert(result != null, 'No TilesWrapperConfig found in context');
    return result!;
  }

  @override
  bool updateShouldNotify(TilesConfig oldWidget) => true;
}
