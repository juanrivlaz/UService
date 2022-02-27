import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:uService/providers/app_provider.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/router_service.dart';
import 'package:uService/services/setup_service.dart';
import 'package:uService/utils/app_settings.dart';
import 'package:uService/utils/preference_user.dart';
import 'package:uService/widgets/startup_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final prefs = new PreferencesUser();
  await prefs.initPrefs();

  setupService();

  runApp(UServiceApp());
}

class UServiceApp extends StatefulWidget {
  @override
  UServiceState createState() => new UServiceState();
}

class UServiceState extends State<UServiceApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppProvider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'uService',
        theme: appService<AppSettings>().appTheme,
        localizationsDelegates: [GlobalMaterialLocalizations.delegate],
        supportedLocales: [const Locale('es')],
        navigatorKey: appService<NavigationService>().navigationKey,
        onGenerateRoute: generateRoute,
        home: StartUpView(),
      ),
    );
  }
}