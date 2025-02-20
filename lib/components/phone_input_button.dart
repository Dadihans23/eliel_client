// import 'package:flutter/material.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';

// class PhoneInputButton extends StatelessWidget {
//   final Function(bool) onInputValidated;
//   final bool ignoreBlank;
//   final AutovalidateMode autoValidateMode;
//   final TextStyle selectorTextStyle;
//   final TextEditingController textFieldController;
//   final InputDecoration inputDecoration;
//   final bool formatInput;

//   const PhoneInputButton({
//     Key? key,
//     required this.onInputChanged,
//     required this.onInputValidated,
//     required this.selectorConfig,
//     required this.ignoreBlank,
//     required this.autoValidateMode,
//     required this.selectorTextStyle,
//     this.initialValue,
//     required this.textFieldController,
//     required this.inputDecoration,
//     required this.formatInput,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return InternationalPhoneNumberInput(
//       onInputChanged: onInputChanged,
//       onInputValidated: onInputValidated,
//       selectorConfig: selectorConfig,
//       ignoreBlank: ignoreBlank,
//       autoValidateMode: autoValidateMode,
//       selectorTextStyle: selectorTextStyle,
//       initialValue: initialValue,
//       textFieldController: textFieldController,
//       inputDecoration: inputDecoration,
//       formatInput: formatInput,
//     );
//   }
// }
