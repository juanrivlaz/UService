import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/pages/agencies/bloc/agency_bloc.dart';

Widget inputAgencyBrand(AgencyBloc bloc) {
  return StreamBuilder(
    stream: bloc.brandStream,
    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
      return DropdownButtonFormField<int>(
        value: snapshot.hasData ? snapshot.data : null,
        hint: Text('Seleccione una marca'),
        onChanged: bloc.changeBrand,
        isExpanded: true,
        items: (bloc.brands ?? []).map((brand) => DropdownMenuItem(
          value: brand.id,
          child: Text(brand.name)
        )).toList(),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          border: OutlineInputBorder(),
        ),
      );
    },
  );
}
