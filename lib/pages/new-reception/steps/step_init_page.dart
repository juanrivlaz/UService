import 'package:flutter/material.dart';
import 'package:uService/models/DMS/vehicle_model.dart';
import 'package:uService/models/type_service_model.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';

double width(BuildContext context) {

  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.width * .9;
  }

  return MediaQuery.of(context).size.width > 700
      ? MediaQuery.of(context).size.width * .55
      : MediaQuery.of(context).size.width;
}

Widget init(
  BuildContext context,
  ReceptionBloc bloc,
  List<TypeServiceModel> typesService,
  Function addAuto
) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(25),
          child: Text('Tipo de Servicio',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 15),
          width: width(context),
          child: StreamBuilder(
            stream: bloc.typeServiceStream,
            builder: (BuildContext ctxTypeService, AsyncSnapshot<int> snpTypeService) {
              return DropdownButtonFormField<int>(
                isExpanded: true,
                hint: Text('Seleccione un tipo'),
                value: snpTypeService.hasData ? snpTypeService.data : null,
                items: typesService.map((TypeServiceModel value) {
                  return DropdownMenuItem<int>(
                    value: value.id,
                    child: new Text(value.label),
                  );
                }).toList(),
                onChanged: bloc.changeTypeService,
                decoration: const InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
                  border: OutlineInputBorder(),
                ),
              );
            },
          )
        ),
        Container(
          margin: EdgeInsets.all(25),
          child: Text('Comentario',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
        ),
        Container(
          width: width(context),
          margin: EdgeInsets.all(25),
          child: StreamBuilder(
            stream: bloc.customerCommentStream,
            builder: (BuildContext cxtComment, AsyncSnapshot snpComment) {
              return TextFormField(
                controller: bloc.customerCommentController,
                maxLines: 8,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  errorText: snpComment.hasError ? snpComment.error : null
                ),
                onChanged: bloc.changeCustomerComment,
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(25),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Buscar vehiculo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                )
              ),
              IconButton(onPressed: addAuto, icon: Icon(Icons.add_circle, size: 30))
            ]
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
          child: StreamBuilder(
            stream: bloc.vehiclesStream,
            builder: (BuildContext ctxVehicle, AsyncSnapshot snpVehicle) {

              List<VehicleModel> data = snpVehicle.hasData ? snpVehicle.data : [];

              return Column(
                children: data.map((vehicle) => Column(
                  children: [
                    
                    ListTile(
                      onTap: () {
                        bloc.changeVehicle(vehicle);
                        bloc.updateResume();
                      },
                      title: Text('PLACAS: ${vehicle.placas}'),
                      subtitle: Text('SERIE: ${vehicle.serie}'),
                    ),
                    Divider()
                  ],
                )).toList(),
              );
            },
          ),
        )
      ],
    ),
  );
}
