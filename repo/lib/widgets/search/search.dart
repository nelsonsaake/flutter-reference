import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mytrotro/palettes/colors.dart';
import 'package:mytrotro/styles/rounded.dart';

class Search extends StatelessWidget {
  const Search({
    super.key,
    this.controller,
    this.onEditingComplete,
    this.onChanged,
  });

  final TextEditingController? controller;
  final VoidCallback? onEditingComplete;
  final void Function(String)? onChanged;

  get inputBorder => OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black.withOpacity(0.2),
          width: 0.5,
        ),
        borderRadius: rounded(10),
      );

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {},
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      onFieldSubmitted: (value) => FocusScope.of(context).unfocus(),
      style: const TextStyle(
        fontSize: 16.0,
        color: Colors.black87,
      ),
      controller: controller ?? TextEditingController(),
      decoration: InputDecoration(
        border: inputBorder,
        focusedBorder: inputBorder,
        enabledBorder: inputBorder,
        hintText: 'Search',
        hintStyle: const TextStyle(
          fontSize: 15.0,
          color: Colors.black87,
        ),
        filled: true,
        fillColor: AppColors.searchDep,
        prefixIcon: const Icon(
          Iconsax.search_normal_1,
          size: 21,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 16,
        ),
      ),
      validator: (value) {
        if (value == null) {
          return '';
        }
        return null;
      },
    );
  }
}
