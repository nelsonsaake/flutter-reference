import 'package:flutter/material.dart';
import 'package:flutter_phosphor_icons/flutter_phosphor_icons.dart';
import 'package:semper_web/app_resources/app_colors.dart';
import 'package:semper_web/styles/input_styles.dart';

class SearchInput extends StatefulWidget {
  final String label;

  final bool obscureText;

  final double? borderRadius;

  final FocusNode? focusNode;

  final EdgeInsets? padding;

  final TextEditingController? controller;

  const SearchInput({
    Key? key,
    this.label = "",
    this.padding,
    this.obscureText = false,
    this.focusNode,
    this.controller,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<SearchInput> createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  late FocusNode focusNode = widget.focusNode ?? FocusNode();

  @override
  void initState() {
    focusNode.addListener(listenToFocusNode);
    super.initState();
  }

  void listenToFocusNode() {
    setState(() {});
  }

  BorderRadius get borderRadius {
    return (widget.borderRadius == null)
        ? InputStyles.borderRadius
        : BorderRadius.circular(widget.borderRadius!);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // push everything in
      padding: widget.padding ?? const EdgeInsets.only(left: 8, right: 4),
      // height: InputStyles.height,

      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width,
      ),

      decoration: BoxDecoration(
        //
        color: AppColors.cream,

        boxShadow: InputStyles.shadow,

        border: (focusNode.hasFocus)
            ? InputStyles.focusedBorder
            : InputStyles.border,

        borderRadius: borderRadius,
      ),

      clipBehavior: Clip.hardEdge,

      child: ClipRRect(
        //
        borderRadius: borderRadius,

        child: Center(
          child: TextField(
            //
            focusNode: focusNode,

            controller: widget.controller,

            obscureText: widget.obscureText,

            style: InputStyles.textStyle,

            decoration: InputDecoration(
              //
              prefixIcon: Icon(
                PhosphorIcons.magnifying_glass_bold,
                color: focusNode.hasFocus
                    ? InputStyles.focusColor
                    : AppColors.text,
              ),

              filled: true,
              fillColor: AppColors.gray.withOpacity(0.1),

              border: InputBorder.none,

              hintText: widget.label,
            ),
          ),
        ),
      ),
    );
  }
}
