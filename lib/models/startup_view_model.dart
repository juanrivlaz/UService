import 'package:flutter/material.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/setup_service.dart';
import 'package:uService/utils/preference_user.dart';

class StartupViewModel extends ChangeNotifier {
  final PreferencesUser _pref = new PreferencesUser();
  final NavigationService _navigationService = appService<NavigationService>();

  Future<void> handleStartUp() async {
    bool loggedUser = _pref.logged;

    Future.delayed(Duration(milliseconds: 1500)).then((value) {
      if (loggedUser) {
        _navigationService.navigateToAndRemoveHistory( _pref.activeRoute != '' ? _pref.activeRoute : 'receptios');
      } else {
        _navigationService.navigateToAndRemoveHistory('login');
      }
    });
  }
}