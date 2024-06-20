import 'package:flutter/material.dart';
import 'package:mytrotro/palettes/colors.dart';
import 'package:mytrotro/styles/rounded.dart';
import 'package:mytrotro/widgets/otp_input/otp_input_viewmodel.dart';
import 'package:stacked/stacked.dart';

class OtpInput extends StackedView<OtpInputViewmodel> {
  const OtpInput({
    super.key,
    this.otpLen = 4,
    this.onCompleted,
    this.onChanged,
  });

  final int otpLen;
  final void Function(String)? onCompleted;
  final void Function(String)? onChanged;

  //
  final inputWidth = 50.0;
  final gap = 20.0;

  OutlineInputBorder inputBorder({
    BorderRadius? br,
    Color? color,
    double? width,
  }) {
    return OutlineInputBorder(
      borderRadius: br ?? rounded(8),
      borderSide: BorderSide(
        color: color ?? Colors.transparent,
        width: width ?? 2,
      ),
    );
  }

  @override
  Widget builder(BuildContext context, OtpInputViewmodel viewModel, _) {
    //
    final length = viewModel.otpLen;

    //
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...List.generate(
            length,
            (index) => Row(
              children: [
                SizedBox(
                  width: inputWidth,
                  child: TextField(
                    autofocus: index == 0 && length != 4 ? true : false,
                    controller: viewModel.getController(index),
                    focusNode: viewModel.getNode(index),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    cursorColor: AppColors.joinColor,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.joinColor,
                      fontSize: 22,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey.withOpacity(0.15),
                      border: inputBorder(),
                      enabledBorder: inputBorder(),
                      focusedBorder: inputBorder(color: AppColors.joinColor),
                    ),
                    onChanged: (value) {
                      viewModel.onFieldChanged(context, index);
                    },
                  ),
                ),
                if (index != length - 1) ...[SizedBox(width: gap)]
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  OtpInputViewmodel viewModelBuilder(BuildContext context) {
    return OtpInputViewmodel(
      otpLen: otpLen,
      onCompleted: onCompleted,
      onChanged: onChanged,
    );
  }
}
