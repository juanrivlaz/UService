import 'package:flutter/material.dart';
import 'package:uService/pages/login/bloc/login_bloc.dart';

Widget buttonSubmit(LoginBloc bloc, Function submit) {
  return StreamBuilder(
    stream: bloc.formValidStream,
    builder: (BuildContext ctx, AsyncSnapshot snp) {
      bool valid = snp.hasData && snp.data;

      return StreamBuilder(
        stream: bloc.loadingStream,
        builder: (BuildContext ctxloadin, AsyncSnapshot snploading) {
          bool loading = snploading.hasData && snploading.data;

          return Opacity(
            opacity: valid && !loading ? 1 : .5,
            child: ElevatedButton(
              onPressed: valid && !loading ? submit : null,
              child: Text('Iniciar Sesión', style: TextStyle(color: Colors.white),),
              style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.symmetric(vertical: 15)),
                backgroundColor: MaterialStateProperty.all(Color.fromRGBO(19, 81, 216, 1)),
                elevation: MaterialStateProperty.all(0),
                shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)))
              ),
            ),
          );
        },
      );
    },
  );
}