import 'package:get_it/get_it.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/rest_service.dart';
import 'package:uService/utils/app_settings.dart';
import 'package:uService/utils/general.dart';

GetIt appService = GetIt.instance;

void setupService() {
  appService.registerLazySingleton(() => AppSettings());
  appService.registerLazySingleton(() => NavigationService());
  appService.registerLazySingleton(() => General());
  appService.registerLazySingleton(() => RestService());
}