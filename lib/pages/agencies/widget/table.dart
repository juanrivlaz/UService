import 'package:flutter/material.dart';
import 'package:uService/models/agency_model.dart';
import 'package:uService/pages/agencies/bloc/agency_bloc.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/setup_service.dart';

Widget table(AgencyBloc bloc, double width, Function(AgencyModel) edit) {
  return StreamBuilder(
    stream: bloc.listAgencyStream,
    builder: (BuildContext ctx, AsyncSnapshot<List<AgencyModel>> snapshot) {
      return StreamBuilder(
        stream: bloc.loadingAgencyStream,
        builder: (BuildContext ctxAgency, AsyncSnapshot snpAgency) {
          if (snpAgency.hasData && snpAgency.data) {
            return Container(
              width: width > 600 ? width * .8 : width,
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }

          var data = snapshot.hasData ? snapshot.data : [];

          var table = DataTable(
                  headingRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  dataRowColor:
                      MaterialStateColor.resolveWith((states) => Colors.white),
                  columns: [
                    DataColumn(label: Text('NOMBRE')),
                    DataColumn(label: Text('MARCA')),
                    DataColumn(label: Text('CIUDAD')),
                    DataColumn(label: Text('ESTADO')),
                    DataColumn(label: Text('ACCIONES'))
                  ],
                  rows: data
                      .map((agency) => DataRow(cells: [
                            DataCell(Text(agency.name)),
                            DataCell(Text(agency.brand.name)),
                            DataCell(Text(agency.city.name)),
                            DataCell(Text(agency.state.name)),
                            DataCell(DropdownButton<String>(
                                onChanged: (value) {
                                  if (value == 'package') {
                                    appService<NavigationService>().navigateTo('agency-package', arguments: agency);
                                  }

                                  if (value == 'edit') {
                                    edit(agency);
                                  }
                                },
                                value: null,
                                hint: Text('Acciones'),
                                items: [
                                  DropdownMenuItem(
                                        value: 'edit', child: Text('Editar')),
                                  DropdownMenuItem(
                                        value: 'details', child: Text('Detalles')),
                                  DropdownMenuItem(
                                        value: 'package', child: Text('Paquetes'))
                                ]))
                          ]))
                      .toList());

          if (MediaQuery.of(ctx).orientation == Orientation.portrait) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: table,
            );
          }

          return Container(
              child: table
          );
        },
      );
    },
  );
}
