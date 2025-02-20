import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? initialValue;

  const CustomTextField({
    Key? key,
    this.prefixIcon,
    this.suffixIcon,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.indigo),
          borderRadius: BorderRadius.circular(5),
        ),
        filled: true,
        fillColor: Colors.white,
        hintStyle: TextStyle(
          fontSize: 12,
          color: Colors.grey[400],
        ),
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
      ),
      controller: TextEditingController(text: initialValue),
    );
  }
}
