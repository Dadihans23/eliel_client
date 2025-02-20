import 'package:flutter/material.dart';

class NameTextField extends StatelessWidget {
  final String hintText;
    final TextEditingController? controller; // Ajout du contrôleur


  const NameTextField({Key? key, required this.hintText , this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black , fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          
          contentPadding: EdgeInsets.symmetric(vertical: 5.0, horizontal: 20.0),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black),
          ),
      
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: const Color.fromRGBO(63, 81, 181, 1)),
            borderRadius: BorderRadius.circular(8),
          ),
          filled: true,
          fillColor: const Color.fromARGB(255, 110, 110, 110),
          hintStyle: TextStyle(
            fontSize: 12,
            color: Colors.grey[400],
          ),
          hintText: hintText,
        ),
      ),
    );
  }
}
