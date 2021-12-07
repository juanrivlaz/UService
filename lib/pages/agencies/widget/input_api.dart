import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/pages/agencies/bloc/agency_bloc.dart';

Widget inputAgencyApi(AgencyBloc bloc) {
  return StreamBuilder(
    stream: bloc.apiStream,
    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
      return TextField(
        controller: bloc.apiController,
        keyboardType: TextInputType.text,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.4,
                  color: Colors.grey[300],
                  style: BorderStyle.solid),
            ),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
                vertical: 10, horizontal: 16),
          errorText: snapshot.error
        ),
        onChanged: bloc.changeApi,
      );
    }
  );
}