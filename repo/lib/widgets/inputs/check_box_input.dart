import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/extensions/color.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/widgets/text/div.dart';

class CheckBoxInput extends StatefulWidget {
  final String? label;

  final bool isChecked;

  final void Function(bool? value)? onTap;

  const CheckBoxInput({
    Key? key,
    this.label,
    this.isChecked = false,
    this.onTap,
  }) : super(key: key);

  @override
  CheckBoxInputState createState() => CheckBoxInputState();
}

class CheckBoxInputState extends State<CheckBoxInput> {
  late bool isChecked = widget.isChecked;

  void onTap(bool isChecked) {
    if (widget.onTap != null) widget.onTap!(isChecked);
    setState(() {});
  }

  void onLabelClicked() {
    isChecked = !(isChecked);
    onTap(isChecked);
  }

  void onCheckBoxClicked(bool? val) {
    // if null; false otherwise use value
    isChecked = val ?? false;
    onTap(isChecked);
  }

  @override
  Widget build(BuildContext context) {
    final checkboxColor = (isChecked == false) ? AppColors.gray : AppColors.red;

    final checkColor = (isChecked == false) ? AppColors.gray : AppColors.cream;

    final checkboxFillColor =
        (isChecked == false) ? Colors.transparent : checkboxColor;

    final labelColor = (isChecked == false) ? AppColors.text : AppColors.green;

    final side = BorderSide(color: checkboxColor);

    final checkBoxShape = RoundedRectangleBorder(
      side: BorderSide(color: checkboxColor),
      borderRadius: BorderRadius.circular(5),
    );

    return TextButton(
      onPressed: onLabelClicked,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Row(
        children: [
          //
          Checkbox(
            tristate: true,
            shape: checkBoxShape,
            value: isChecked,
            onChanged: onCheckBoxClicked,
            checkColor: checkColor,
            fillColor: checkboxFillColor.toMaterialProperty,
            side: side,
          ),

          //
          Div(widget.label).color(labelColor),
        ],
      ),
    );
  }
}
