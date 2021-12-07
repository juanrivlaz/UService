import 'package:flutter/material.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';

double width(BuildContext context) {

  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.width * .9;
  }

  return MediaQuery.of(context).size.width > 700
      ? MediaQuery.of(context).size.width * .55
      : MediaQuery.of(context).size.width;
}

Widget client(BuildContext context, ReceptionBloc bloc) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(25),
          child: Text(
            'Buscar cliente',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          width: width(context),
          child: Column(
            children: [
              Container(
                child: TextFormField(
                  decoration: InputDecoration(suffixIcon: Icon(Icons.search)),
                ),
              )
            ],
          ),
        ),
        Container(
          width: width(context),
          child: Column(
            children: [
              ListTile(
                title: Text('NOMBRE: Juan Daniel Rivera Lazaro'),
                subtitle: Text('RFC: RILJ930805'),
              ),
              Divider()
            ],
          ),
        )
      ],
    ),
  );
}
