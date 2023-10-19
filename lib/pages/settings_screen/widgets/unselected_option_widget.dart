import 'package:flutter/material.dart';

class UnselectedOptionWidget extends StatelessWidget {
  final String unselectedTitleOption;

  const UnselectedOptionWidget(
      {super.key, required this.unselectedTitleOption});

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
            unselectedTitleOption,
            style: theme.textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}
