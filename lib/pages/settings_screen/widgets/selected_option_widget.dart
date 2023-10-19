import 'package:flutter/material.dart';

class SelectedOptionWidget extends StatelessWidget {
  final String selectedTitleOption;

  const SelectedOptionWidget({super.key, required this.selectedTitleOption});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Container(
      height: 60,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.primaryColor,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white54,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedTitleOption,
            style: theme.textTheme.titleMedium,
          ),
          Icon(
            Icons.check,
            color: theme.primaryColor,
            size: 28,
          )
        ],
      ),
    );
  }
}
