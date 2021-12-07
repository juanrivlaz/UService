import 'dart:async';

import 'dart:io';

class Validators {

  final validEmail = StreamTransformer<String, String>.fromHandlers(
    handleData: (email, sink) {

      Pattern pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
      RegExp regExp   = new RegExp(pattern);

      if (regExp.hasMatch(email)) {
        sink.add(email);
      } else {
        sink.addError('Email no es valido');
      }
    }
  );

  final validHexadecimal = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, snik) {
      Pattern pattern = r'^[A-f0-9]{6}$';
      RegExp regExp   = new RegExp(pattern);

      if (regExp.hasMatch(value)) {
        snik.add(value);
      } else {
        snik.addError('Color no valido');
      }
    }
  );

  final validPassword = StreamTransformer<String, String>.fromHandlers(
    handleData: (password, sink) {

      if (password.length > 0) {
        sink.add( password );
      } else {
        sink.addError('Ingrese una contraseña');
      }
    }
  );

  final validateEmpty = StreamTransformer<String, String>.fromHandlers(
    handleData: (value, sink) {
      if (value.length > 0 && value != null) {
        sink.add(value);
      } else {
        sink.addError('El campo es requerido');
      }
    }
  );

  final validFileEmpty = StreamTransformer<File, File>.fromHandlers(
    handleData: (value, sink) {
      if (value != null) {
        sink.add(value);
      } else {
        sink.addError('El archivo es requerido');
      }
    } 
  );

  final validateDate = StreamTransformer<DateTime, DateTime>.fromHandlers(
    handleData: (value, sink) {
      if (value != null) {
        sink.add(value);
      } else {
        sink.addError('El campo es requerido');
      }
    }
  );

  final validNumber = StreamTransformer<int, int>.fromHandlers(
    handleData: (value, sink) {
      Pattern pattern = r'^[0-9]+$';
      RegExp regExp   = new RegExp(pattern);

      if (regExp.hasMatch(value.toString())) {
        sink.add(value);
      } else {
        sink.addError('numero no valido');
      }
    }
  );

  final validTermAndConditions = StreamTransformer<bool, bool>.fromHandlers(
    handleData: (value, sink) {
      if (value ?? false) {
        sink.add(value);
      } else {
        sink.addError('Es necesario aceptar el aviso de privacidad');
      }
    }
  );
}