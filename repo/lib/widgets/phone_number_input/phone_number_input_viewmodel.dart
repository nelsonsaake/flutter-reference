import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:mytrotro/calling_codes/calling_codes.dart';
import 'package:mytrotro/helpers/str.dart';
import 'package:mytrotro/models/calling_code.dart';
import 'package:mytrotro/viewmodels/context_viewmodel/context_viewmodel.dart';

class PhoneNumberInputViewmodel extends ContextViewModel {
  //...
  final Function(String)? onChanged;

  final TextEditingController? controller;

  PhoneNumberInputViewmodel({this.onChanged, this.controller});

  final textEditController = TextEditingController();

  final focusNode = FocusNode();

  final initialCallingCode = "+233";

  late String? _selectedCallingCode = initialCallingCode;

  late CallingCode? selectedCallingCode =
      CallingCodes.find(_selectedCallingCode);

  bool get isCallingCodeSelected => selectedCallingCode != null;

  setSelectedCallingCode(String? v) {
    _selectedCallingCode = v;
    selectedCallingCode = CallingCodes.find(v);
    notifyListeners();
  }

  removeFocusIfPhoneNumberIsCorrect(String value) async {
    // final isValid = await PhoneNumberUtil().validate(
    //   value,
    //   regionCode: selectedCallingCode?.countryCode,
    // );
    // if (isValid) {
    //   FocusManager.instance.primaryFocus?.unfocus();
    // }

    final validate = ValidationBuilder().phone().build();
    final isValid = validate(value)?.isEmpty == true;
    if (isValid) focusNode.unfocus();
  }

  onChangedWrapper(String v) {
    String digits =
        str(selectedCallingCode?.root) + v.replaceAll(RegExp(r'\D'), '');
    digits = digits.trim();
    removeFocusIfPhoneNumberIsCorrect(digits);
    onChanged?.call(digits);
  }
}
