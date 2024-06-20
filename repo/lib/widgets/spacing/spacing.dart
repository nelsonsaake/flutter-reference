import "package:flutter/material.dart";

class Spacing extends StatelessWidget {
  final Axis? _axis;
  final double spacing;

  const Spacing(this.spacing, {Key? key})
      : _axis = null,
        super(key: key);

  const Spacing.horizontal(this.spacing, {Key? key})
      : _axis = Axis.horizontal,
        super(key: key);

  const Spacing.vertical(this.spacing, {Key? key})
      : _axis = Axis.vertical,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (_axis) {
      case null:
        return SizedBox.square(
          dimension: spacing,
        );
      case Axis.horizontal:
        return SizedBox(
          width: spacing,
        );
      case Axis.vertical:
        return SizedBox(
          height: spacing,
        );
    }
  }
}
