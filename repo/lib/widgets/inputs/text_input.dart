import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/styles/input_styles.dart';
import 'package:semper_web/widgets/text/div.dart';

class TextInput extends StatefulWidget {
  final String label;

  final bool obscureText;

  final bool enabled;

  final bool numbersOnly;

  final FocusNode? focusNode;

  final TextEditingController? controller;

  final List<TextInputFormatter>? inputFormatters;

  final TextInputType? keyboardType;

  final VoidCallback? onEditingComplete;

  //

  static const double padding = 2.0;

  const TextInput({
    Key? key,
    this.label = "",
    this.obscureText = false,
    this.enabled = true,
    this.numbersOnly = false,
    this.focusNode,
    this.controller,
    this.inputFormatters,
    this.keyboardType,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  State<TextInput> createState() => _TextInputState();
}

class _TextInputState extends State<TextInput> {
  late FocusNode focusNode = widget.focusNode ?? FocusNode();

  late bool obscureText = widget.obscureText;

  @override
  void initState() {
    focusNode.addListener(listenToFocusNode);
    super.initState();
  }

  void listenToFocusNode() {
    setState(() {});
  }

  void toggleObscure() {
    setState(() => obscureText = !obscureText);
  }

  get inputFormatters {
    if (widget.numbersOnly) {
      return [FilteringTextInputFormatter.digitsOnly];
    }
    return widget.inputFormatters;
  }

  get keyboardType {
    if (widget.numbersOnly) {
      return TextInputType.number;
    }
    return widget.keyboardType;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // push everything in
      padding: const EdgeInsets.all(TextInput.padding),
      height: InputStyles.height,
      alignment: Alignment.center,

      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),

      decoration: BoxDecoration(
        //
        color: widget.enabled ? AppColors.cream : AppColors.gray01Solid,

        boxShadow: InputStyles.shadow,

        border: (focusNode.hasFocus)
            ? InputStyles.focusedBorder
            : widget.enabled
                ? InputStyles.border
                : InputStyles.borderDisabled,

        borderRadius: InputStyles.borderRadius,
      ),

      clipBehavior: Clip.hardEdge,

      child: TextField(
        //
        focusNode: focusNode,

        controller: widget.controller,

        obscureText: obscureText,

        style: InputStyles.textStyle,

        enabled: widget.enabled,

        inputFormatters: inputFormatters,

        keyboardType: keyboardType,

        onEditingComplete: widget.onEditingComplete,

        decoration: InputDecoration(
          //
          filled: true,

          fillColor: widget.enabled ? AppColors.cream : Colors.transparent,

          border: InputBorder.none,

          label: Div(widget.label).rem(1.1),

          suffixIcon: widget.obscureText
              ? IconButton(
                  onPressed: toggleObscure,
                  icon: Icon(
                    obscureText ? PhosphorIcons.eye_slash : PhosphorIcons.eye,
                    color: (focusNode.hasFocus)
                        ? InputStyles.focusColor
                        : divStyle.color,
                  ),
                )
              : null,
        ),
      ),
    );
  }
}
