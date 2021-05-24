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
          color: Color.fromRGBO(84, 200, 232, 1.0), shape: BoxShape.circle);
    } else if (isToday) {
      boxDecoration = BoxDecoration(
        border: Border.all(
          color: Colors.grey[350],
          width: 2.0,
        ),
        shape: BoxShape.circle,
      );
    }

    return Expanded(
      child: GestureDetector(
        child: Container(
          decoration: isRangeDay() &&
                  calendarroState.selectedDates.first !=
                      calendarroState.selectedDates.last
              ? BoxDecoration(
                  borderRadius: date == calendarroState.selectedDates.first
                      ? BorderRadius.only(
                          topLeft: Radius.circular(30),
                          bottomLeft: Radius.circular(30))
                      : BorderRadius.only(
                          topRight: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                  color: containSelectd() ? Colors.grey[350] : Colors.white,
                )
              : BoxDecoration(
                  color: containSelectd()
                      ? calendarroState.selectedDates.first ==
                              calendarroState.selectedDates.last
                          ? Colors.white
                          : Colors.grey[350]
                      : Colors.white,
                ),
          child: Container(
            height: 40.0,
            decoration: isRangeDay() ? boxDecoration : null,
            child: Center(
              child: Text(
                "${date.day}",
                textAlign: TextAlign.center,
                style:
                    TextStyle(color: isRangeDay() ? Colors.white : textColor),
              ),
            ),
          ),
        ),
        onTap: handleTap,
        behavior: HitTestBehavior.translucent,
      ),
    );
  }

  bool isRangeDay() {
    if (calendarroState.selectedDates.isNotEmpty) {
      if (date == calendarroState.selectedDates.first ||
          date == calendarroState.selectedDates.last) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  bool containSelectd() {
    if (calendarroState.selectedDates.length > 1) {
      if (date == calendarroState.selectedDates.first ||
          date == calendarroState.selectedDates.last) {
        return true;
      }
      if (date.isAfter(calendarroState.selectedDates.first) &&
          date.isBefore(calendarroState.selectedDates.last)) {
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  void handleTap() {
    if (onTap != null) {
      onTap(date);
    }
    calendarroState.setSelectedDate(date);
    calendarroState.setCurrentDate(date);
  }
}
