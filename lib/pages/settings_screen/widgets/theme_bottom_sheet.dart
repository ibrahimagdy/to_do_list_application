import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/pages/settings_screen/widgets/selected_option_widget.dart';
import 'package:to_do_application/pages/settings_screen/widgets/unselected_option_widget.dart';

class ThemeBottomSheet extends StatelessWidget {
  const ThemeBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectedOptionWidget(selectedTitleOption: local.light_mode),
          const SizedBox(height: 20),
          UnselectedOptionWidget(unselectedTitleOption: local.dark_mode),
        ],
      ),
    );
  }
}
