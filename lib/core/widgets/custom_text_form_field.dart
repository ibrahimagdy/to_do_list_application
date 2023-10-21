import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/app_provider.dart';

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
    var appProvider = Provider.of<AppProvider>(context);
    return TextFormField(
      validator: validator,
      controller: controller,
      maxLines: maxLines,
      obscureText: obscureText,
      style: TextStyle(color: theme.primaryColor, fontSize: 18),
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        suffixIconColor: theme.primaryColor,
        labelText: labelText,
        labelStyle: theme.textTheme.headlineMedium,
        hintText: title,
        hintStyle: theme.textTheme.bodyLarge!.copyWith(
          color: appProvider.isLight()
              ? const Color(0xffA9A9A9).withOpacity(0.61)
              : Colors.white.withOpacity(0.7),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: theme.colorScheme.scrim,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide(
            color: theme.colorScheme.scrim,
          ),
        ),
      ),
    );
  }
}
