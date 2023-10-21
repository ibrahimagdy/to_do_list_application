import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/core/provider/app_provider.dart';
import 'package:to_do_application/pages/settings_screen/widgets/selected_option_widget.dart';
import 'package:to_do_application/pages/settings_screen/widgets/unselected_option_widget.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    var appProvider = Provider.of<AppProvider>(context);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
              onTap: () {
                appProvider.changeLanguage("en");
                Navigator.pop(context);
              },
              child: appProvider.isEnglish()
                  ? SelectedOptionWidget(selectedTitleOption: local.english)
                  : UnselectedOptionWidget(
                      unselectedTitleOption: local.english)),
          const SizedBox(height: 20),
          GestureDetector(
              onTap: () {
                appProvider.changeLanguage("ar");
                Navigator.pop(context);
              },
              child: appProvider.isEnglish()
                  ? UnselectedOptionWidget(unselectedTitleOption: local.arabic)
                  : SelectedOptionWidget(selectedTitleOption: local.arabic)),
        ],
      ),
    );
  }
}
