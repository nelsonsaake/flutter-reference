import 'package:flutter/material.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/styles/input_styles.dart';

class LongTextInput extends StatelessWidget {
  final String label;
  final int? lineCount;
  final bool fillHeight;
  final TextEditingController? controller;

  const LongTextInput({
    Key? key,
    this.label = "",
    this.lineCount,
    this.fillHeight = false,
    this.controller,
  }) : //  assert(lineCount != null && fillHeight),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: AppColors.cream,
        boxShadow: InputStyles.shadow,
        borderRadius: InputStyles.borderRadius,
      ),

      child: TextField(
        //
        controller: controller,

        maxLines: lineCount,
        minLines: lineCount,
        expands: fillHeight,

        style: InputStyles.textStyle,

        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: label,
          hintStyle: InputStyles.labelTextStyle,
        ),
      ),
    );
  }
}
