import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/core/network_layer/firestore_utils.dart';
import 'package:to_do_application/core/widgets/custom_text_form_field.dart';
import 'package:to_do_application/model/task_model.dart';

class BottomSheetWidget extends StatefulWidget {
  const BottomSheetWidget({super.key});

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
  var formKey = GlobalKey<FormState>();
  DateTime selectedDate = DateTime.now();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              local.add_new_task,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge!.copyWith(
                color: const Color(0xff383838),
              ),
            ),
            CustomTextFormField(
              title: local.enter_your_task,
              controller: titleController,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return local.you_must_provide_task_title;
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              title: local.enter_your_task_description,
              controller: descriptionController,
              maxLines: 3,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return local.you_must_provide_task_description;
                } else {
                  return null;
                }
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  local.select_date,
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: const Color(0xff383838),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCalender(context);
                  },
                  child: Text(
                    DateFormat.yMMMd().format(selectedDate),
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      var model = TaskModel(
                        title: titleController.text,
                        description: descriptionController.text,
                        dateTime: selectedDate,
                        isDone: false,
                      );
                      await FirestoreUtils.addDataToFireStore(model);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    local.add_task,
                    style: theme.textTheme.bodyLarge!.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showCalender(BuildContext context) async {
    var dateSelected = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (dateSelected == null) return;
    selectedDate = dateSelected;
    setState(() {});
  }
}
