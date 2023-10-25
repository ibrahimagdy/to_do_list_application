import 'package:flutter/material.dart';

typedef SettingsOptionClicked = void Function();

class SettingsItem extends StatelessWidget {
  final String settingOptionTitle;
  final String settingOptionSelected;
  final SettingsOptionClicked onTabOption;

  const SettingsItem(
      {super.key,
      required this.settingOptionTitle,
      required this.settingOptionSelected,
      required this.onTabOption});

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    var theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: Text(
            settingOptionTitle,
            textAlign: TextAlign.start,
            style: theme.textTheme.bodyLarge!.copyWith(
              color: theme.colorScheme.scrim,
            ),
          ),
        ),
        GestureDetector(
          onTap: onTabOption,
          child: Container(
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(25),
            width: mediaQuery.width,
            height: 50,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(2),
              border: Border.all(
                color: theme.primaryColor,
                width: 3,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  settingOptionSelected,
                  style: theme.textTheme.bodyLarge,
                ),
                Icon(
                  Icons.arrow_drop_down,
                  color: theme.colorScheme.primary,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
