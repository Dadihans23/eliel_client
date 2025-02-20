import 'package:flutter/material.dart';

class DescriptionRow extends StatelessWidget {
  final String descriptionTitle;
  final String descriptionText;
  final VoidCallback onPressed;

  const DescriptionRow({
    Key? key,
    required this.descriptionTitle,
    required this.descriptionText,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: EdgeInsets.only(right: 10),
            child: Text(
              descriptionTitle,
              style: TextStyle(
                color: Colors.grey.shade300,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                descriptionText,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 0),
            child: IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.lock, color: Colors.white, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
