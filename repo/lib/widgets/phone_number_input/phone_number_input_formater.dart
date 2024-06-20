import 'package:flutter/services.dart';

// PhoneNumberFormatter: breaks the input the into space separated segments
// eg. 123456789, segments = [2, 3, 4] becomes 12 345 6789
class PhoneNumberFormatter extends TextInputFormatter {
  //...

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {

    // specify segments
    const segments = [2, 3, 4];

    // Remove any characters that are not digits
    var digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    // make sure the first digit is not a zero
    if(digitsOnly.startsWith("0")){
      digitsOnly = digitsOnly.substring(1);
    }

    // the output
    var formatted = "";

    // pull out numbers, segment by segment into formatted version
    for (int i = 0; i < segments.length; i++) {

      // segment len
      final seg = segments[i];

      // if we have more digits than this segment requires
      // 1.
      // we copy the number of digits this segment requires and
      // add it to the formatted text
      // 2.
      // we remove the return what's left for the next iteration
      // we return it by making it the vale of digitsOnly
      if (seg <= digitsOnly.length) {

        // add the current segment into the formatted text
        formatted = "$formatted ${digitsOnly.substring(0, seg)}".trim();

        // remove the current segment for the next loop
        digitsOnly = digitsOnly.substring(seg);

      }else{

        // append whatever is left to the formatted string
        formatted = "$formatted $digitsOnly".trim();

        break;
      }
    }

    // Maintain the cursor position
    int selectionIndex = formatted.length;

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
