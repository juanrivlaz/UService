import 'package:flutter/material.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/setup_service.dart';
import 'package:uService/utils/preference_user.dart';

Widget drawerApp(PreferencesUser pref) {
  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: [
        DrawerHeader(
            margin: EdgeInsets.zero,
            padding: EdgeInsets.zero,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/background_menu.jpg'))),
            child: Stack(children: <Widget>[
              Positioned(
                  bottom: 12.0,
                  left: 16.0,
                  child: Text('${pref.name} ${pref.lastName}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500))),
            ])),
        ListTile(
          title: Row(
            children: <Widget>[
              Icon(Icons.domain),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Agencias'),
              )
            ],
          ),
          onTap: () => appService<NavigationService>().navigateTo('agencies'),
        ),
        ListTile(
          title: Row(
            children: <Widget>[
              Icon(Icons.content_paste),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Recepción'),
              )
            ],
          ),
          onTap: () => appService<NavigationService>().navigateTo('receptios'),
        ),
        ListTile(
          title: Row(
            children: <Widget>[
              Icon(Icons.analytics),
              Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text('Reportes'),
              )
            ],
          ),
          onTap: () => appService<NavigationService>().navigateTo('report'),
        )
      ],
    ),
  );
}
