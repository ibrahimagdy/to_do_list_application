import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:to_do_application/core/network_layer/firestore_utils.dart';
import 'package:to_do_application/model/task_model.dart';
import 'package:to_do_application/pages/edit_task/edit_task.dart';

import '../../../core/provider/app_provider.dart';

class TaskItemWidget extends StatefulWidget {
  const TaskItemWidget({super.key, required this.taskModel});

  final TaskModel taskModel;

  @override
  State<TaskItemWidget> createState() => _TaskItemWidgetState();
}

class _TaskItemWidgetState extends State<TaskItemWidget> {
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    var appProvider = Provider.of<AppProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: appProvider.isEnglish()
              ? [
            const Color(0xFFEC4B4B),
            const Color(0xFFEC4B4B),
            const Color(0xFFE8DD1B),
            const Color(0xFFE8DD1B),
          ]
              : [
            const Color(0xFFE8DD1B),
            const Color(0xFFE8DD1B),
            const Color(0xFFEC4B4B),
            const Color(0xFFEC4B4B),
          ],
        ),
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                await FirestoreUtils.deleteDataFromFirestore(widget.taskModel);
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: const Color(0xFFEC4B4B),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: local.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          extentRatio: 0.2,
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                Navigator.pushNamed(context, EditTask.routeName,
                    arguments: widget.taskModel);
              },
              borderRadius: BorderRadius.circular(15),
              backgroundColor: const Color(0xFFE8DD1B),
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: local.edit,
            ),
          ],
        ),
        child: Container(
          width: 400,
          height: 125,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: theme.colorScheme.outline,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                width: 5,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: widget.taskModel.isDone
                      ? const Color(0xff61E757)
                      : theme.primaryColor,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 200,
                      maxHeight: 500,
                    ),
                    child: Text(
                      widget.taskModel.title,
                      style: widget.taskModel.isDone
                          ? theme.textTheme.displayMedium
                          : theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    constraints: const BoxConstraints(
                      maxWidth: 200,
                      maxHeight: 500,
                    ),
                    child: Text(
                      widget.taskModel.description,
                      style: widget.taskModel.isDone
                          ? theme.textTheme.displayMedium
                          : theme.textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        CupertinoIcons.clock,
                        size: 20,
                        color: theme.colorScheme.scrim,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        DateFormat.yMMMEd().format(widget.taskModel.dateTime),
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: () {
                  FirestoreUtils.isDone(widget.taskModel);
                  setState(() {});
                },
                child: widget.taskModel.isDone
                    ? Text(
                        local.done,
                        style: theme.textTheme.displayMedium!.copyWith(
                          fontSize: 22,
                        ),
                      )
                    : Container(
                        width: 70,
                        height: 37,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: theme.primaryColor,
                        ),
                        child: Image.asset("assets/images/check_icon.png"),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
