import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/pages/settings_screen/widgets/language_bottom_sheet.dart';
import 'package:to_do_application/pages/settings_screen/widgets/settings_item.dart';
import 'package:to_do_application/pages/settings_screen/widgets/theme_bottom_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          color: theme.primaryColor,
          width: double.infinity,
          height: 160,
          child: Text(
            local.settings,
            style: theme.textTheme.titleLarge,
          ),
        ),
        const SizedBox(height: 30),
        SettingsItem(
          settingOptionTitle: local.language,
          settingOptionSelected: local.english,
          onTabOption: () {
            showLanguageBottomSheet(context);
          },
        ),
        SettingsItem(
          settingOptionTitle: local.theme_mode,
          settingOptionSelected: local.light_mode,
          onTabOption: () {
            showThemeBottomSheet(context);
          },
        ),
      ],
    );
  }

  void showLanguageBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (context) => const LanguageBottomSheet(),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
        ));
  }

  void showThemeBottomSheet(context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => const ThemeBottomSheet(),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(40)),
      ),
    );
  }
}
