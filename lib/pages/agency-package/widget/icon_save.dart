import 'package:flutter/material.dart';
import 'package:uService/pages/agency-package/bloc/agency_package_bloc.dart';

Widget iconSave(AgencyPackageBloc bloc, Function submit) {
  return StreamBuilder(
    stream: bloc.loadingSaveStream,
    builder: (BuildContext ctx, AsyncSnapshot snp) {
      return (snp.hasData && snp.data) ? 
      SizedBox(
        width: 45,
        height: 30,
        child: Align(
          child: Container(
            width: 45, height: 30,
            margin: EdgeInsets.only(right: 15),
          child: CircularProgressIndicator(strokeWidth: 3,)),
        ),
      ) :
      StreamBuilder(
        stream: bloc.loadingStream,
        builder: (BuildContext ctxdata, AsyncSnapshot snpdata) {
          if(snpdata.hasData && !snpdata.data) {
            return IconButton(onPressed: submit, icon: Icon(Icons.done));
          }

          return Container();
        }
      );
    },
  );
}