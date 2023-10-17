import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String? title;
  final String? labelText;
  final FormFieldValidator<String>? validator;
  final int maxLines;
  bool obscureText;
  Widget? suffixIcon;

  CustomTextFormField({
    super.key,
    this.title,
    required this.controller,
    this.validator,
    this.suffixIcon,
    this.labelText,
    this.maxLines = 1,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: theme.primaryColor,
        labelText: labelText,
        labelStyle: theme.textTheme.bodyLarge!.copyWith(
          color: Colors.black,
        ),
        hintText: title,
        hintStyle: theme.textTheme.bodyLarge!.copyWith(
          color: const Color(0xffA9A9A9).withOpacity(0.61),
        ),
      ),
    );
  }
}
