// import 'package:flutter/material.dart';

// class PasswordTextField extends StatefulWidget {
//   final TextEditingController controller;
//   final String? hintText;
//   final IconData? suffixIconData;
//   final Color? suffixIconColor;
//   final double? suffixIconSize;
//   final String? errorText;

//   const PasswordTextField({
//     Key? key,
//     required this.controller,
//      this.hintText,
//     this.suffixIconData,
//     this.suffixIconColor,
//     this.suffixIconSize,
//     this.errorText,
//   }) : super(key: key);

//   @override
//   _PasswordTextFieldState createState() => _PasswordTextFieldState();
// }

// class _PasswordTextFieldState extends State<PasswordTextField> {
//   bool isObscure = true;

//   @override
//   Widget build(BuildContext context) {
//     return 
//        TextField(
//         controller: widget.controller,
//         obscureText: isObscure,
//         style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
//         decoration: InputDecoration(
//           contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
//           enabledBorder: const OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.white),
//           ),
//           focusedBorder: OutlineInputBorder(
//             borderSide: BorderSide(color: Colors.white),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           filled: true,
//           fillColor: Colors.transparent,
//           hintText: "",
//           hintStyle: TextStyle(
//             fontSize: 12,
//             color: Colors.white,
//           ),
//           suffixIcon: widget.suffixIconData != null
//               ? IconButton(
//                   icon: Icon(
//                     isObscure ? Icons.visibility : Icons.visibility_off,
//                     color: widget.suffixIconColor ?? Colors.grey,
//                   ),
//                   onPressed: () {
//                     setState(() {
//                       isObscure = !isObscure;
//                     });
//                   },
//                 )
//               : null,
//         ),
//       );
  
//   }
// }
