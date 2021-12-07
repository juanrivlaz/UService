import 'package:flutter/widgets.dart';
import 'package:uService/blocs/app_bloc.dart';

class AppProvider extends InheritedWidget {

  static AppProvider _instance;
  final appBloc = new AppBloc();

  factory AppProvider({ Key key, Widget child }) {

    if ( _instance == null ){
      _instance = new AppProvider._internal(key: key, child: child);
    }

    return _instance;
  }

  AppProvider._internal({ Key key, Widget child })
    : super(key: key, child: child);

  @override
    bool updateShouldNotify(covariant InheritedWidget oldWidget) => true;

  static AppBloc of (BuildContext context) {
    return ( context.dependOnInheritedWidgetOfExactType<AppProvider>()).appBloc;
  }
}