import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_colors.dart';

class BusyIndicator extends StatelessWidget {
  final Color color;

  const BusyIndicator({Key? key, this.color = AppColors.green})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Center(
        child: SizedBox.square(
          dimension: 16,
          child: CircularProgressIndicator(
            color: color,
            strokeWidth: 2,
          ),
        ),
      ),
    );
  }
}
