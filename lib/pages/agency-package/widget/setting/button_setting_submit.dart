import 'package:flutter/material.dart';
import 'package:uService/pages/agency-package/bloc/setting_bloc.dart';

Widget buttonSettingSubmit(SettingBloc bloc, Function submit) {
  return StreamBuilder(
    stream: bloc.loadingStream,
    builder: (BuildContext ctxLoading, AsyncSnapshot shpLoading) {
      return StreamBuilder(
        stream: bloc.formValidStream,
        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
          return Opacity(
            opacity: !(shpLoading.hasData && shpLoading.data) && snapshot.hasData && snapshot.data ? 1 : .4,
            child: ElevatedButton(
              onPressed: !(shpLoading.hasData && shpLoading.data) && snapshot.hasData && snapshot.data ? submit : null,
              child: shpLoading.hasData && shpLoading.data
                  ? SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                  : Text(
                      'Guardar',
                      style: TextStyle(color: Colors.white),
                    ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      EdgeInsets.symmetric(vertical: 15)),
                  backgroundColor:
                      MaterialStateProperty.all(Color.fromRGBO(19, 81, 216, 1)),
                  elevation: MaterialStateProperty.all(0),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)))),
            ),
          );
        },
      );
    },
  );
}
