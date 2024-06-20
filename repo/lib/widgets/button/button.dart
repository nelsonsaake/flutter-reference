import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/extensions/button_style.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/styles/input_styles.dart';
import 'package:semper_web/widgets/spacing/spacing.dart';
import 'package:semper_web/widgets/text/div.dart';

class Button extends StatelessWidget {
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final bool setBorder;
  final VoidCallback? onTap;
  final bool busy;
  final bool fillWidth;
  final double? borderRadius;
  final IconData? icon;

  const Button(
    this.text, {
    Key? key,
    this.backgroundColor = AppColors.green,
    this.textColor = Colors.white,
    this.setBorder = false,
    this.onTap,
    this.busy = false,
    this.fillWidth = true,
    this.borderRadius,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //...

    const double height = 60;

    final borderRadius = this.borderRadius ?? 10;

    var style = const ButtonStyle()
        .br(borderRadius)
        .ms(150, height)
        .pd(h: 26, v: 5)
        .bg(backgroundColor);

    if (fillWidth) {
      style = style.size(double.maxFinite, height);
    }

    if (setBorder) {
      style = style.border(color: AppColors.green, size: 1);
    }

    final label = Div(text).color(textColor).center();

    Widget? child = label;

    if (icon != null) {
      child = Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          //...

          label,

          const Spacing(8),

          Icon(icon, color: textColor)
        ],
      );
    }

    final busyIndicator = SizedBox.square(
      //...

      dimension: label.style?.fontSize,

      child: CircularProgressIndicator(color: textColor, strokeWidth: 2),
    );

    return Container(
      //...

      decoration: BoxDecoration(
        boxShadow: InputStyles.shadow,
        borderRadius: BorderRadius.circular(borderRadius),
      ),

      child: ElevatedButton(
        onPressed: onTap ?? () {},
        style: style,
        child: busy ? busyIndicator : child,
      ),
    );
  }
}
