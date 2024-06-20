import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/styles/input_styles.dart';
import 'package:semper_web/widgets/text/div.dart';

class SelectInput<T> extends StatelessWidget {
  final String label;
  final Map<String, T> entries;
  final T? value;
  final void Function(T?)? onSelect;

  const SelectInput(
    this.label, {
    Key? key,
    this.entries = const {},
    this.onSelect,
    this.value,
  }) : super(key: key);

  Widget buildIcon() {
    return Icon(
      PhosphorIcons.caret_down_bold,
      color: InputStyles.textStyle?.color,
      size: 20,
    );
  }

  List<DropdownMenuItem<T>> buildDropdownMenuItems() {
    List<DropdownMenuItem<T>> items = [];
    entries.forEach(
      (key, value) {
        items.add(
          DropdownMenuItem(
            value: value,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (value == this.value) Div(label).size(14),
                Text(key, style: InputStyles.textStyle),
              ],
            ),
          ),
        );
      },
    );
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //
      padding: const EdgeInsets.symmetric(horizontal: 16),
      height: InputStyles.height,

      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
        minHeight: InputStyles.height,
        maxHeight: InputStyles.height,
      ),

      decoration: BoxDecoration(
        color: AppColors.cream,
        boxShadow: InputStyles.shadow,
        border: InputStyles.border,
        borderRadius: InputStyles.borderRadius,
      ),

      clipBehavior: Clip.hardEdge,

      child: Center(
        child: DropdownButton<T>(
          hint: Div(label).rem(1.1),
          isExpanded: true,
          icon: buildIcon(),
          items: buildDropdownMenuItems(),
          value: value,
          onChanged: onSelect,
          dropdownColor: AppColors.cream,
          underline: Container(),
        ),
      ),
    );
  }
}
