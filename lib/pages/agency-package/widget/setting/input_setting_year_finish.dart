import 'package:flutter/material.dart';
import 'package:uService/pages/agency-package/bloc/setting_bloc.dart';

Widget inputSettingYearFinish(SettingBloc bloc) {
  return StreamBuilder(
    stream: bloc.yearFinishStream,
    builder: (BuildContext ctx, AsyncSnapshot snp) {
      return TextField(
        controller: bloc.yearFinishTextController,
        keyboardType: TextInputType.number,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                  width: 1.4,
                  color: Colors.grey[300],
                  style: BorderStyle.solid)
          ),
          border: OutlineInputBorder(),
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          errorText: snp.error
        ),
        onChanged: (String value) => bloc.changeYearFinish(int.tryParse(value) ?? 0),
      );
    },
  );
}