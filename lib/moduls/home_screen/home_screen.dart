import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    return Stack(
      alignment: const Alignment(0, 2.5),
      children: [
        Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 50),
          color: theme.primaryColor,
          width: double.infinity,
          height: 160,
          child: Text(
            "To Do List",
            style: theme.textTheme.titleLarge,
          ),
        ),
        CalendarTimeline(
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(
            days: 365,
          )),
          onDateSelected: (date) => print(date),
          leftMargin: 20,
          monthColor: Colors.white,
          dayColor: Colors.black,
          activeDayColor: theme.primaryColor,
          activeBackgroundDayColor: Colors.white,
          dotsColor: theme.primaryColor,
          selectableDayPredicate: (date) => date.day != 23,
          locale: 'en_ISO',
        )
      ],
    );
  }
}
