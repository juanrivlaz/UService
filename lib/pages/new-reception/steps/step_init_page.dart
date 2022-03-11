import 'package:flutter/material.dart';
import 'package:uService/models/DMS/marca_model.dart';
import 'package:uService/models/DMS/modelo_model.dart';
import 'package:uService/models/input_select.dart';
import 'package:uService/models/type_service_model.dart';
import 'package:uService/pages/new-reception/bloc/auto_bloc.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';
import 'package:uService/pages/new-reception/widget/input_select.dart';

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
  AutoBloc autoBloc,
  List<TypeServiceModel> typesService,
  Function addAuto,
  List<MarcaModel> marcas,
  Function(int) selectVehicle
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
          child: Center(
            child: Text(
              'Seleccionar vehiculo',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
        ),
        Container(
          width: width(context),
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          child: Text('Marca', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
        ),
        Container(
          width: width(context),
          margin: EdgeInsets.symmetric(horizontal: 25),
          child: inputSelect(
            stream: autoBloc.marcaStream,
            change: autoBloc.changeMarca,
            label: 'Seleccione una marca',
            items: marcas.map((marca) => InputSelect(value: marca.id, label: marca.description)).toList()
          )
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 12, horizontal: 25),
          child: Text('Modelo', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
        ),
        StreamBuilder(
          stream: autoBloc.marcaStream,
          builder: (BuildContext ctx, AsyncSnapshot<int> snp) {
            return Container(
              width: width(context),
              margin: EdgeInsets.symmetric(horizontal: 25),
              child: inputSelect(
                stream: autoBloc.modelStream,
                change: (int value) {
                  autoBloc.changeModel(value);
                  selectVehicle(value);
                },
                label: 'Seleccione un modelo',
                items: getModelos(marcas, snp.data).map((model) => InputSelect(value: model.id, label: model.description)).toList()
              ),
            );
          },
        ),
        SizedBox(height: 60)
      ],
    ),
  );
}


List<ModeloModel> getModelos(List<MarcaModel> marcas, int idMarca) {

  if (idMarca == null) return [];

  MarcaModel marca = marcas.firstWhere((element) => element.id == idMarca);
  marca.models.sort((a, b) => a.description.compareTo(b.description));

  return marca.models;

}