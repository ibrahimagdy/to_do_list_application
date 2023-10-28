import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/core/provider/app_provider.dart';
import 'package:to_do_application/pages/login/login_screen.dart';
import 'package:to_do_application/pages/settings_screen/widgets/language_bottom_sheet.dart';
import 'package:to_do_application/pages/settings_screen/widgets/settings_item.dart';
import 'package:to_do_application/pages/settings_screen/widgets/theme_bottom_sheet.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var mediaQuery = MediaQuery.of(context).size;
    var local = AppLocalizations.of(context)!;
    var appProvider = Provider.of<AppProvider>(context);
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
          settingOptionSelected:
          appProvider.isEnglish() ? local.english : local.arabic,
          onTabOption: () {
            showLanguageBottomSheet(context);
          },
        ),
        const SizedBox(height: 30),
        SettingsItem(
          settingOptionTitle: local.theme_mode,
          settingOptionSelected:
          appProvider.isLight() ? local.light_mode : local.dark_mode,
          onTabOption: () {
            showThemeBottomSheet(context);
          },
        ),
        GestureDetector(
          onTap: () {
            showLogoutConfirmationDialog(context);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            margin: const EdgeInsets.all(25),
            width: mediaQuery.width * 0.55,
            height: 50,
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer,
              border: Border.all(
                color: theme.primaryColor,
                width: 3,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  local.logout,
                  style: theme.textTheme.bodyLarge,
                ),
                Icon(
                  Icons.logout,
                  color: theme.primaryColor,
                  size: 28,
                ),
              ],
            ),
          ),
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
      ),
    );
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

  void showLogoutConfirmationDialog(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var theme = Theme.of(context);
    showDialog(
      context: context,
      builder: (dialogContext) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  local.log_out_of_your_account,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.grey,
                  thickness: 1.5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop();
                        },
                        child: Text(
                          local.cancel,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: theme.primaryColor,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          Navigator.of(dialogContext).pop(); // Close the dialog
                          var auth = FirebaseAuth.instance;
                          auth.signOut().then((value) {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          });
                        },
                        child: Text(
                          local.logout,
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
