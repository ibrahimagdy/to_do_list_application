import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:to_do_application/core/network_layer/firestore_utils.dart';
import 'package:to_do_application/model/task_model.dart';
import 'package:to_do_application/pages/home_screen/widgets/task_item_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var local = AppLocalizations.of(context)!;
    return Column(
      children: [
        Stack(
          alignment: const Alignment(0, 12),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(horizontal: 50),
              color: theme.primaryColor,
              width: double.infinity,
              height: 140,
              child: Text(
                local.to_do_list,
                style: theme.textTheme.titleLarge,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
              margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2),
              decoration: BoxDecoration(
                color: theme.colorScheme.outline.withOpacity(0.5),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: CalendarTimeline(
                initialDate: selectedDate,
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 365)),
                onDateSelected: (date) {
                  if (selectedDate != date) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
                leftMargin: 20,
                monthColor: Colors.white,
                dayColor: theme.colorScheme.scrim,
                activeDayColor: theme.primaryColor,
                activeBackgroundDayColor: Colors.white,
                dotsColor: theme.primaryColor,
              ),
            ),
          ],
        ),
        const SizedBox(height: 78),
        Expanded(
          child: StreamBuilder<QuerySnapshot<TaskModel>>(
            stream: FirestoreUtils.getRealTimeDataFromFireStore(selectedDate),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(snapshot.error.toString()),
                    const SizedBox(height: 20),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.refresh),
                    ),
                  ],
                );
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: theme.primaryColor,
                  ),
                );
              }
              var tasksList =
                  snapshot.data?.docs.map((e) => (e.data())).toList() ?? [];
              return ListView.builder(
                itemBuilder: (context, index) => TaskItemWidget(
                  taskModel: tasksList[index],
                ),
                itemCount: tasksList.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
