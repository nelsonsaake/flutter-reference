import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:mytrotro/palettes/colors.dart';

enum InputFieldType {
  mobile,
}

String? hintText(InputFieldType? inputFieldType) {
  switch (inputFieldType) {
    case InputFieldType.mobile:
      return '024 856 3218';
    default:
      return '';
  }
}

String? Function(String?)? validation(InputFieldType? inputFieldType) {
  switch (inputFieldType) {
    case InputFieldType.mobile:
      return ValidationBuilder().phone().build();
    default:
      return null;
  }
}

TextInputType? keyboard(InputFieldType? inputFieldType) {
  switch (inputFieldType) {
    case InputFieldType.mobile:
      return TextInputType.phone;
    default:
      return null;
  }
}

class InputField extends StatelessWidget {
  final TextEditingController? controller;
  final InputFieldType? inputFieldType;
  final Function(String)? onChanged;

  const InputField({
    super.key,
    this.controller,
    this.inputFieldType,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard(inputFieldType),
      controller: controller,
      onChanged: onChanged != null ? (value) => onChanged!(value) : null,
      decoration: inputDecoration(),
      validator: validation(inputFieldType),
    );
  }

  InputDecoration inputDecoration() {
    return InputDecoration(
      filled: true,
      hintText: hintText(inputFieldType),
      fillColor: Colors.grey[200],
      border: border(),
      hintStyle: hintStyle(),
      contentPadding: padding(),
    );
  }

  EdgeInsets padding() {
    return const EdgeInsets.symmetric(
      horizontal: 16.0,
      vertical: 17,
    );
  }

  OutlineInputBorder border() {
    return OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.circular(10.0),
    );
  }

  static TextStyle hintStyle() {
    return const TextStyle(
      color: AppColors.hintColor,
    );
  }
}
