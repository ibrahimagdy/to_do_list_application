import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final FormFieldValidator<String>? validator;
  final int maxLines;

  const CustomTextFormField({
    super.key,
    required this.title,
    required this.controller,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: theme.textTheme.bodyLarge!.copyWith(
          color: const Color(0xffA9A9A9).withOpacity(0.61),
        ),
      ),
    );
  }
}
