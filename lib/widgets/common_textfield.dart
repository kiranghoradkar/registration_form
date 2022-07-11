import 'package:flutter/material.dart';
import 'package:registration_form/common_strings.dart';

class CommonTextField extends StatelessWidget {
  final IconData? commonIcon;
  final String hintTextField;
  final String labelTextField;
  final TextEditingController? userInput;
  const CommonTextField(
       this.hintTextField, this.labelTextField,
      {Key? key,this.commonIcon,this.userInput})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'This field is required';
          }
          return null;
        },
        controller: userInput,
        decoration: InputDecoration(
            prefixIcon: Icon(commonIcon),
            border: const OutlineInputBorder(),
            hintText: hintTextField,
            labelText: labelTextField),
      ),
    );
  }
}
