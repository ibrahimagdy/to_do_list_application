import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/provider/app_provider.dart';

class SelectedOptionWidget extends StatelessWidget {
  final String selectedTitleOption;

  const SelectedOptionWidget({super.key, required this.selectedTitleOption});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appProvider = Provider.of<AppProvider>(context);
    return Container(
      height: 60,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(
          color: theme.primaryColor,
          width: 3,
        ),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white54,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            selectedTitleOption,
            style: appProvider.isLight()
                ? theme.textTheme.titleMedium
                : theme.textTheme.headlineMedium,
          ),
          Icon(
            Icons.check,
            color: theme.colorScheme.tertiary,
            size: 28,
          )
        ],
      ),
    );
  }
}
