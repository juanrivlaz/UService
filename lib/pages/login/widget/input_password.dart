import 'package:flutter/material.dart';
import 'package:uService/pages/login/bloc/login_bloc.dart';

Widget inputPassword(LoginBloc bloc) {
  return StreamBuilder(
    stream: bloc.passwordStream,
    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
      return TextField(
        keyboardType: TextInputType.text,
        enableSuggestions: false,
        autocorrect: false,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          labelText: 'Contraseña',
          labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
          prefixIcon: Icon(Icons.lock, color: Color.fromRGBO(19, 81, 216, 1), size: 20,),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color.fromRGBO(220, 220, 220, .9))
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey)
          ),
          errorText: snapshot.error
        ),
        onChanged: bloc.changePassword,
      );
    },
  );
}