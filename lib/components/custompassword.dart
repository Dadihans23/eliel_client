import 'package:flutter/material.dart';

class PasswordTextField extends StatefulWidget {
  final TextEditingController controller;
  final String? hintText;
  final IconData? suffixIconData;
  final double? suffixIconSize;
  final String? errorText;
  final Widget? prefixIcon;

  const PasswordTextField({
    Key? key,
    required this.controller,
    this.hintText,
    this.suffixIconData,
    this.suffixIconSize,
    this.errorText,
    this.prefixIcon,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8 , horizontal: 20),
      child: TextFormField(
        controller: widget.controller,
        obscureText: isObscure,
        style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: Colors.transparent,
          hintText: widget.hintText,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade700,
          ),
          prefixIcon: widget.prefixIcon,
          suffixIcon: widget.suffixIconData != null
              ? IconButton(
                  icon: Icon(
                    isObscure ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      isObscure = !isObscure;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
