import 'package:flutter/material.dart';
import 'package:semper_web/extensions/text.dart';
import 'package:semper_web/widgets/text/div.dart';

class ErrorText extends StatelessWidget {
  final String text;

  const ErrorText(this.text, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 4,
          horizontal: 32,
        ),
        child: Div(text.trim()).red().center(),
      ),
    );
  }
}
