import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:mytrotro/calling_codes/calling_codes.dart';
import 'package:mytrotro/helpers/str.dart';
import 'package:mytrotro/models/calling_code.dart';
import 'package:mytrotro/styles/border.dart';
import 'package:mytrotro/styles/padding.dart';
import 'package:mytrotro/styles/rounded.dart';
import 'package:mytrotro/widgets/input_field/input_field.dart';
import 'package:mytrotro/widgets/space.dart';
import 'package:stacked/stacked.dart';

import 'phone_number_input_formater.dart';
import 'phone_number_input_viewmodel.dart';

class PhoneNumberInput extends StackedView<PhoneNumberInputViewmodel> {
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const PhoneNumberInput({
    super.key,
    this.controller,
    this.onChanged,
  });

  Widget buildInternetFlag(CallingCode cc) {
    return CachedNetworkImage(
      width: 25,
      height: 20,
      fit: BoxFit.cover,
      imageUrl: str(cc.flag),
      errorWidget: (context, url, error) => const SizedBox(),
    );
  }

  Widget buildAssetFlag(CallingCode? cc) {
    final asset = "assets/flags/${cc?.countryCode?.toLowerCase()}.png";
    return Image.asset(
      asset,
      width: 25,
      height: 20,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) => const SizedBox(),
    );
  }

  Widget buildCallingCode(CallingCode? cc) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildAssetFlag(cc),
        const Space.x(16),
        // Text(str(cc?.root)),
        Expanded(
          child: Text(
            str(cc?.countryName),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget buildSelectedFlag(
    BuildContext context,
    PhoneNumberInputViewmodel viewModel,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        buildAssetFlag(viewModel.selectedCallingCode),
      ],
    );
  }

  Widget buildSelectedLabel(
    BuildContext context,
    PhoneNumberInputViewmodel viewModel,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(str(viewModel.selectedCallingCode?.root)),
      ],
    );
  }

  Widget buildDropDown(
    BuildContext context,
    PhoneNumberInputViewmodel viewModel,
  ) {
    return DropdownMenu(
      width: 350,
      menuHeight: 350,
      expandedInsets: EdgeInsets.zero,
      initialSelection: viewModel.initialCallingCode,
      onSelected: viewModel.setSelectedCallingCode,
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
      ),
      dropdownMenuEntries: [
        for (final cc in CallingCodes.all)
          DropdownMenuEntry(
            label: "",
            value: str(cc.root),
            labelWidget: buildCallingCode(cc),
          ),
      ],
    );
  }

  Widget buildDropDownWrap(
    BuildContext context,
    PhoneNumberInputViewmodel viewModel,
  ) {
    return SizedBox(
      height: 50,
      child: Stack(
        children: [
          const Center(),
          SizedBox(
            height: 50,
            width: 90,
            child: buildDropDown(context, viewModel),
          ),
          Container(
            padding: pl(13),
            height: 50,
            width: 40,
            child: buildSelectedFlag(context, viewModel),
          )
        ],
      ),
    );
  }

  @override
  Widget builder(
    BuildContext context,
    PhoneNumberInputViewmodel viewModel,
    _,
  ) {
    return ClipRRect(
      borderRadius: roundedmd(),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          border: border(),
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            const Center(),
            buildDropDownWrap(context, viewModel),
            buildSelectedLabel(context, viewModel),
            const Space.x(13),
            Expanded(
              flex: 1,
              child: TextFormField(
                controller: viewModel.controller,
                focusNode: viewModel.focusNode,
                inputFormatters: [PhoneNumberFormatter()],
                onChanged: viewModel.onChangedWrapper,
                keyboardType: TextInputType.phone,
                validator: ValidationBuilder().phone().build(),
                decoration: InputDecoration(
                  hintText: '24 856 3218',
                  hintStyle: InputField.hintStyle(),
                  border: InputBorder.none,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  PhoneNumberInputViewmodel viewModelBuilder(
    BuildContext context,
  ) {
    return PhoneNumberInputViewmodel(onChanged: onChanged);
  }
}
