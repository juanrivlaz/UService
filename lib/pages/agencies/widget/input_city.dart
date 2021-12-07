import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/models/state_model.dart';
import 'package:uService/pages/agencies/bloc/agency_bloc.dart';

Widget inputAgencyCity(AgencyBloc bloc) {
  return StreamBuilder(
    stream: bloc.cityStream,
    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
      return StreamBuilder(
          stream: bloc.stateStream,
          builder: (BuildContext ctxState, AsyncSnapshot snpState) {
            StateModel state = StateModel.fromJson({});
            if (bloc.states != null) {
              var statefind = bloc.states.firstWhere(
                  (state) => state.id == bloc.state,
                  orElse: () => null);

              if (statefind != null) {
                state = statefind;
              }
            }

            return DropdownButtonFormField<int>(
              value: snapshot.hasData && snapshot.data > 0 ? snapshot.data : null,
              hint: Text('Seleccione una ciudad'),
              onChanged: bloc.changeCity,
              isExpanded: true,
              items: state.cities
                  .map((city) => DropdownMenuItem(
                      value: city.id ?? 0, child: Text(city.name ?? '')))
                  .toList(),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                border: OutlineInputBorder(),
              ),
            );
          });
    },
  );
}
