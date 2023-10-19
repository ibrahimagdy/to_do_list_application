import 'package:flutter/material.dart';
import 'package:to_do_application/pages/settings_screen/widgets/selected_option_widget.dart';
import 'package:to_do_application/pages/settings_screen/widgets/unselected_option_widget.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 35),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SelectedOptionWidget(selectedTitleOption: "English"),
          SizedBox(height: 20),
          UnselectedOptionWidget(unselectedTitleOption: "Arabic"),
        ],
      ),
    );
  }
}
