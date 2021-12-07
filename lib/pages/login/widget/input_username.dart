import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/pages/login/bloc/login_bloc.dart';

Widget inputUsername(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.emailStream,
    builder: (BuildContext context, AsyncSnapshot snp) {
      return TextField(
        keyboardType: TextInputType.emailAddress,
        enableSuggestions: false,
        autocorrect: false,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          labelText: 'Usuario',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
          prefixIcon: Icon(Icons.alternate_email, color: Color.fromRGBO(19, 81, 216, 1), size: 20),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, .9))
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          errorText: snp.error
        ),
        onChanged: bloc.changeEmail,
      );
    },
  );
}