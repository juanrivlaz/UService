import 'package:flutter/material.dart';
import 'package:uService/models/agency_model.dart';
import 'package:uService/pages/agencies/agencies_page.dart';
import 'package:uService/pages/agency-package/agency_package_page.dart';
import 'package:uService/pages/confirm-data/confirm_data_page.dart';
import 'package:uService/pages/login/login_page.dart';
import 'package:uService/pages/new-reception/new_reception_page.dart';
import 'package:uService/pages/reception/reception_page.dart';
import 'package:uService/pages/report/report_page.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case 'login':
      return MaterialPageRoute(builder: (context) => LoginPage(), settings: settings);
    case 'agencies':
      return MaterialPageRoute(builder: (context) => AgenciesPage(), settings: settings);
    case 'agency-package':
      AgencyModel agency = AgencyModel.fromJson({});

      if (settings.arguments is AgencyModel) {
        agency = settings.arguments as AgencyModel;
      }

      return MaterialPageRoute(builder: (context) => AgencyPackagePage(agency: agency), settings: settings);
    case 'confirm_data':
      return MaterialPageRoute(builder: (context) => ConfirmDataPage(), settings: settings);
    case 'reception':
      return MaterialPageRoute(builder: (context) => NewReceptionPage(), settings: settings);
    case 'receptios':
      return MaterialPageRoute(builder: (context) => ReceptionPage(), settings: settings);
    case 'report':
      return MaterialPageRoute(builder: (context) => ReportPage(), settings: settings);

    default:
      return MaterialPageRoute(
          builder: (context) => Container(), settings: settings);
  }
}