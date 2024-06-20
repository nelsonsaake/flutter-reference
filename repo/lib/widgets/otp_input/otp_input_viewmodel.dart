import 'package:flutter/material.dart';
import 'package:mytrotro/viewmodels/context_viewmodel/context_viewmodel.dart';

class OtpInputViewmodel extends ContextViewModel {
  //...

  final int otpLen;
  final void Function(String)? onChanged;
  final void Function(String)? onCompleted;

  OtpInputViewmodel({this.otpLen = 4, this.onChanged, this.onCompleted});

  // input controls

  late final inputKeys = List.generate(otpLen, (index) => GlobalKey());

  late final nodes = List.generate(otpLen, (index) => FocusNode());

  late final inputs = List.generate(otpLen, (index) => "");

  late final controllers =
      List.generate(otpLen, (index) => TextEditingController());

  // getters for the input controlls

  FocusNode? getNode(int i) {
    if (0 <= i && i < nodes.length) {
      return nodes[i];
    }
    return null;
  }

  TextEditingController? getController(int i) {
    if (0 <= i && i < controllers.length) {
      return controllers[i];
    }
    return null;
  }

  GlobalKey? getKey(int i) {
    if (0 <= i && i < inputKeys.length) {
      return inputKeys[i];
    }
    return null;
  }

  // go to next input box, or the previous one

  jumpForward(BuildContext context, int index) {
    if (index == nodes.length - 1) return;
    nodes[index].unfocus();
    FocusScope.of(context).requestFocus(nodes[index + 1]);
  }

  jumpBack(BuildContext context, int index) {
    if (index == 0) return;
    nodes[index].unfocus();
    FocusScope.of(context).requestFocus(nodes[index - 1]);
  }

  // current value

  String get code {
    return controllers.map((n) => n.text).toList().join("");
  }

  // decide what happens when something changes,
  // do we go to the next input box
  // or the previous one

  String _prevInput = "";

  onFieldChanged(BuildContext context, int index) {
    //...

    final controller = getController(index);
    final nextController = getController(index + 1);
    final prevController = getController(index - 1);
    final isTextAdded = code.length > _prevInput.length;

    if ((controller?.text.length ?? 0) > 1) {
      controller?.text = controller.text.split("").last;
    }

    if (isTextAdded) {
      jumpForward(context, index);
      if (nextController?.text.isEmpty == true) {
        nextController?.text = " ";
      }
    } else {
      jumpBack(context, index);
      if (prevController?.text.isEmpty == true) {
        prevController?.text = " ";
      }
    }

    // if user has finished typing in the code
    // we run the onCompleted function if it is set
    if (code.trim().length == otpLen) {
      onCompleted?.call(code);
    }

    // run onChange
    onChanged?.call(code);

    _prevInput = code;
  }
}
