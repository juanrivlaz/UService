import 'package:flutter/material.dart';
import 'package:uService/models/DMS/client_model.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';

double width(BuildContext context) {

  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.width * .9;
  }

  return MediaQuery.of(context).size.width > 700
      ? MediaQuery.of(context).size.width * .55
      : MediaQuery.of(context).size.width;
}

Widget client(
  BuildContext context,
  ReceptionBloc bloc,
  Function addClient
) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(25),
          child: Row(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    'Buscar cliente',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                ),
              ),
              IconButton(onPressed: addClient, icon: Icon(Icons.add_circle, size: 30,))
            ],
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
            stream: bloc.clientsStream,
            builder: (BuildContext ctxClients, AsyncSnapshot<List<ClientModel>> snpClients) {
              List<ClientModel> clients = snpClients.hasData ? snpClients.data : [];

              return Column(
                children: clients.map((client) => Column(
                  children: [
                    ListTile(
                      onTap: () {
                        bloc.changeClient(client);
                        var auto = bloc.vehicleModel;
                        auto.client = client;
                        bloc.changeVehicle(auto);
                        bloc.updateResume();
                      },
                      title: Text('NOMBRE: ${client.name}'),
                      subtitle: Text('RFC: ${client.rfc}'),
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
