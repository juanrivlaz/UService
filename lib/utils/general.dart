import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class General {
  selectDate(BuildContext context, DateTime dateInitial,
      Function(DateTime) change, DateTime lastDate) async {
    final DateTime date = await showDatePicker(
        context: context,
        initialDate: dateInitial,
        firstDate: DateTime(1993),
        lastDate: lastDate,
        locale: const Locale("es", "MX"),
        builder: (BuildContext ctx, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  ColorScheme.light(primary: Theme.of(context).primaryColor),
            ),
            child: child,
          );
        });

    if (date != null) {
      change(date);
    }
  }

  selectTime(BuildContext context, Function(TimeOfDay) change) async {
    final TimeOfDay date = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        builder: (BuildContext ctx, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme:
                  ColorScheme.light(primary: Theme.of(context).primaryColor),
            ),
            child: child,
          );
        });

    if (date != null) {
      change(date);
    }
  }

  double calculateDistance(double currentLat, double currentLong, double lat,
      double long, String type) {

    var lat1 = currentLat;
    var lon1 = currentLong;
    var lat2 = lat;
    var lon2 = long;

    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 + c(lat1 * p) * c(lat2 * p) * (1 - c((lon2 - lon1) * p)) / 2;

    return 12742 * asin(sqrt(a));
  }

  void showAlert(BuildContext context, String title, String message) async {
    await showDialog(
        context: context,
        builder: (BuildContext ctx) => AlertDialog(
              title: Text(title, textAlign: TextAlign.center),
              content: Text(message, textAlign: TextAlign.center),
            ));
  }
}
