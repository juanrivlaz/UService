import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppSettings {
  String apiUrl;

  ThemeData appTheme;
  List<Locale> locales;
  Map<String, String> headers;
  bool envprod = false;

  AppSettings() {
    this.apiUrl = '192.168.15.8:90';

    this.appTheme = ThemeData(
        primaryColor: Color.fromRGBO(19, 81, 216, 1),
        primaryColorDark: Colors.black,
        primaryColorLight: Colors.white,
        fontFamily: 'BMWMotorrad',
        accentColor: Colors.blue);
    this.locales = [const Locale('es')];
    this.headers = {
      HttpHeaders.contentTypeHeader: 'application/x-www-form-urlencoded'
    };
  }

  DateFormat get dateFormat {
    return new DateFormat('dd-MMMM-yyyy', 'es_MX');
  }
}
