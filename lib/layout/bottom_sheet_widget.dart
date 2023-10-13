import 'package:flutter/material.dart';
import 'package:to_do_application/core/widgets/custom_text_form_field.dart';

class BottomSheetWidget extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  BottomSheetWidget({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Add New Task",
              textAlign: TextAlign.center,
              style: theme.textTheme.titleLarge!.copyWith(
                color: const Color(0xff383838),
              ),
            ),
            CustomTextFormField(
              title: "Enter your task",
              controller: titleController,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return "You must provide task title";
                } else {
                  return null;
                }
              },
            ),
            CustomTextFormField(
              title: "Enter your task description",
              controller: descriptionController,
              maxLines: 3,
              validator: (String? value) {
                if (value == null || value.trim().isEmpty) {
                  return "You must provide task description";
                } else {
                  return null;
                }
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Select Date",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: const Color(0xff383838),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    showCalender(context);
                  },
                  child: Text(
                    "13 oct 2023",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: theme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print(titleController.text);
                }
              },
              child: Text(
                "Add Task",
                style: theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showCalender(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }
}
