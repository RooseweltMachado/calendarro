import 'package:calendarro/calendarro.dart';
import 'package:calendarro/date_utils.dart';
import 'package:flutter/material.dart';

class CalendarroDayItem extends StatelessWidget {
  CalendarroDayItem({this.date, this.calendarroState, this.onTap});

  DateTime date;
  CalendarroState calendarroState;
  DateTimeCallback onTap;

  @override
  Widget build(BuildContext context) {
    bool isWeekend = DateUtils.isWeekend(date);
    var textColor = isWeekend ? Colors.grey : Colors.black;
    bool isToday = DateUtils.isToday(date);
    calendarroState = Calendarro.of(context);

    bool daySelected = calendarroState.isDateSelected(date);

    BoxDecoration boxDecoration;
    if (daySelected) {
      boxDecoration = BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff6ad3ca), Color(0xff44aaa1)]),
          shape: BoxShape.circle
      );
    } else if (isToday) {
      boxDecoration = BoxDecoration(
          border: Border.all(
            color: Colors.grey,
            width: 2.0,
          ),
          shape: BoxShape.circle);
    }

    return Expanded(
        child: GestureDetector(
          child:

          Container(
            color: Colors.white,
            child: Container(
                height: 40.0,
                decoration: boxDecoration,
                child: Center(
                    child: Text(
                      "${date.day}",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: daySelected ? Colors.white : textColor),
                    ))),
          ),

          onTap: handleTap,
          behavior: HitTestBehavior.translucent,
        ));
  }

  void handleTap() {
    if (onTap != null) {
      onTap(date);
    }

    calendarroState.setSelectedDate(date);
    calendarroState.setCurrentDate(date);
  }
}
