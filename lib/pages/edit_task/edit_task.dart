import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/intl.dart';
import 'package:to_do_application/core/network_layer/firestore_utils.dart';
import 'package:to_do_application/model/task_model.dart';

class EditTask extends StatefulWidget {
  const EditTask({Key? key}) : super(key: key);
  static const String routeName = "edit_task";

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    var args = ModalRoute.of(context)!.settings.arguments as TaskModel;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        backgroundColor: theme.primaryColor,
        title: Text(
          local.edit_task,
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 20,
                child: Container(
                  margin: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: local.add_task,
                        ),
                        initialValue: args.title,
                        onChanged: (value) {
                          setState(() {
                            args.title = value;
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: local.enter_your_task_description,
                        ),
                        initialValue: args.description,
                        onChanged: (value) {
                          setState(() {
                            args.description = value;
                          });
                        },
                      ),
                      const SizedBox(height: 25),
                      Text(
                        "The Date",
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        DateFormat.yMMMd().format(args.dateTime),
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 25),
                      ElevatedButton(
                        onPressed: () {
                          FirestoreUtils.editTask(args);
                          Navigator.pop(context);
                        },
                        child: Text(
                          local.edit_task,
                          style: theme.textTheme.bodyLarge!
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
