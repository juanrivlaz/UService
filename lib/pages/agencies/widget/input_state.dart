import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/pages/agencies/bloc/agency_bloc.dart';

Widget inputAgencyState(AgencyBloc bloc) {
  return StreamBuilder(
    stream: bloc.stateStream,
    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
      return DropdownButtonFormField<int>(
        value: snapshot.hasData ? snapshot.data : null,
        hint: Text('Seleccione un estado'),
        onChanged: (int value) => {
          bloc.changeState(value),
          bloc.changeCity(0)
        },
        isExpanded: true,
        items: (bloc.states ?? []).map((state) => DropdownMenuItem(
          value: state.id,
          child: Text(state.name)
        )).toList(),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          border: OutlineInputBorder(),
        ),
      );
    },
  );
}
