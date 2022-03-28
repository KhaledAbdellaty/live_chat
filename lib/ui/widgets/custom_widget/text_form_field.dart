import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  TextEditingController controller = TextEditingController();
  final String? hint;
  final bool? isSecure;
  TextInputType? type;
  final String? errorText;
  String? Function(String? value) validate;

  MyTextFormField(
      {required this.controller,
      required this.hint,
      required this.isSecure,
      required this.type,
      required this.errorText,
      required this.validate});

  borderDesign(Color color) {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(15),
        borderSide: BorderSide(
          color: color,
        ));
  }
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      cursorColor: Colors.blue[900]!,
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      decoration: InputDecoration(
        hintText: hint,
        errorBorder: borderDesign(Colors.red),
        enabledBorder: borderDesign(Colors.blue[900]!),
        focusedBorder: borderDesign(Colors.blue[900]!),
        focusedErrorBorder: borderDesign(Colors.red),
      ),
      onSaved: (value) {
        controller.text = value!;
      },
      validator: validate,
      obscureText: isSecure!,
      enableSuggestions: true,
      maxLines: 1,
    );
  }
}
