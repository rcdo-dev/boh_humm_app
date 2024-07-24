import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String? labelText;

  const AppTextFormField({
    super.key,
    this.labelText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: 330,
      child: TextFormField(
        cursorColor: Colors.black,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          labelText: labelText,
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
      ),
    );
  }
}
