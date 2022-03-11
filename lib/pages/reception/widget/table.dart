import 'package:flutter/material.dart';

Widget table(BuildContext context) {
  return DataTable(
    headingRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
    dataRowColor: MaterialStateColor.resolveWith((states) => Colors.white),
    columns: [
      DataColumn(label: Text('PLACAS')),
      DataColumn(label: Text('NOMBRE')),
      DataColumn(label: Text('MARCA')),
      DataColumn(label: Text('MODELO')),
      DataColumn(label: Text('AÑO')),
      DataColumn(label: Text('SERVICIO')),
      DataColumn(label: Text('ESTATUS'))
    ],
    rows: [],
  );
}
