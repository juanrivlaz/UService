import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
    rows: [
      DataRow(cells: [
        DataCell(Text('JNU8093')),
        DataCell(Text('JUAN DANIEL RIVERA LAZARO')),
        DataCell(Text('MAZDA')),
        DataCell(Text('3')),
        DataCell(Text('2017')),
        DataCell(Text('60,000 KM')),
        DataCell(Icon(Icons.cloud_upload_rounded))
      ]),
      DataRow(cells: [
        DataCell(Text('JNU8093')),
        DataCell(Text('JUAN DANIEL RIVERA LAZARO')),
        DataCell(Text('MAZDA')),
        DataCell(Text('3')),
        DataCell(Text('2017')),
        DataCell(Text('60,000 KM')),
        DataCell(Icon(Icons.done))
      ]),
      DataRow(cells: [
        DataCell(Text('JNU8093')),
        DataCell(Text('JUAN DANIEL RIVERA LAZARO')),
        DataCell(Text('MAZDA')),
        DataCell(Text('3')),
        DataCell(Text('2017')),
        DataCell(Text('60,000 KM')),
        DataCell(Icon(Icons.cloud_upload_rounded))
      ]),
      DataRow(cells: [
        DataCell(Text('JNU8093')),
        DataCell(Text('JUAN DANIEL RIVERA LAZARO')),
        DataCell(Text('MAZDA')),
        DataCell(Text('3')),
        DataCell(Text('2017')),
        DataCell(Text('60,000 KM')),
        DataCell(Icon(Icons.cloud_upload_rounded))
      ])
    ],
  );
}
