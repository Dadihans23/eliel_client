// textfield.dart

import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText; // Ajoutez ce paramètre
  final IconData? suffixIconData;
  final Color? suffixIconColor;
  final double? suffixIconSize;
  final String? errorText;

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.suffixIconData,
    this.suffixIconColor,
    this.suffixIconSize,
    this.errorText,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 25),
      child: TextField(
        controller: widget.controller,
        obscureText: widget.obscureText,
        style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 110, 110, 110),
          hintText: widget.hintText,
          errorText: widget.errorText,
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
          ),
          suffixIcon: widget.suffixIconData != null
              ? widget.suffixIconData == Icons.email // Vérifiez si l'icône est associée à l'email
                  ? Padding(
                      padding: const EdgeInsets.only(right: 8.0), // Ajoutez un padding à droite pour séparer l'icône du texte
                      child: Icon(
                        widget.suffixIconData,
                        size: widget.suffixIconSize ?? 20.0,
                        color: widget.suffixIconColor ?? Colors.grey,
                      ),
                    )
                  : IconButton(
                      icon: Icon(
                        obscureText ? Icons.visibility : Icons.visibility_off,
                        color: widget.suffixIconColor ?? Colors.grey,
                      ),
                      onPressed: () {
                        setState(() {
                          obscureText = !obscureText;
                        });
                      },
                    )
              : null,
        ),
      ),
    );
  }
}
