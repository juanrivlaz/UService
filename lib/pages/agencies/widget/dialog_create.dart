import 'package:flutter/material.dart';
import 'package:uService/pages/agencies/bloc/agency_bloc.dart';
import 'package:uService/pages/agencies/widget/input_api.dart';
import 'package:uService/pages/agencies/widget/input_brand.dart';
import 'package:uService/pages/agencies/widget/input_city.dart';
import 'package:uService/pages/agencies/widget/input_color.dart';
import 'package:uService/pages/agencies/widget/input_name.dart';
import 'package:uService/pages/agencies/widget/input_state.dart';

Widget dialogCreate(
    BuildContext context,
    AgencyBloc bloc,
    TextEditingController colorController,
    Function uploadLogo,
    Function openColor,
    Function submit,
    Function close) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: StreamBuilder(
      stream: bloc.loadingDataStream,
      builder: (BuildContext ctx, AsyncSnapshot spt) {
        if (spt.hasData && spt.data) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Container(
      width: MediaQuery.of(context).size.width * .8,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            height: 730,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 24),
                      child: Center(
                        child: Text(
                          'AGENCIA',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 19),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text('Nombre',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputAgencyName(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Marca',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputAgencyBrand(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Estado',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputAgencyState(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Ciudad',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputAgencyCity(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Color',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      width: double.infinity,
                      child: inputAgencyColor(bloc, colorController, openColor),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Api Url',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      width: double.infinity,
                      child: inputAgencyApi(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Logotipo',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    GestureDetector(
                      onTap: uploadLogo,
                      child: StreamBuilder(
                        stream: bloc.fileStream,
                        builder: (BuildContext ctx, AsyncSnapshot snap) {
                          return Container(
                            height: snap.hasData && snap.data.path != '' ? null : 80,
                            color: Colors.blue[50],
                            child: snap.hasData && snap.data.path != ''
                            ? Center(
                                child: Image.file(snap.data),
                              )
                            : Center(
                                child: Text('Subir Logotipo',
                                    style: TextStyle(
                                        color: Colors.grey[600])),
                              ),
                          );
                        },
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      width: double.infinity,
                      child: StreamBuilder(
                        stream: bloc.loadingStream,
                        builder: (BuildContext ctxLoading, AsyncSnapshot shpLoading) {
                          return StreamBuilder(
                        stream: bloc.fromValidStream,
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          return Opacity(
                            opacity: snapshot.hasData && snapshot.data ? 1 : .4,
                            child: ElevatedButton(
                              onPressed: shpLoading.hasData && !shpLoading.data && snapshot.hasData && snapshot.data
                                  ? submit
                                  : null,
                              child: shpLoading.hasData && shpLoading.data ?
                                CircularProgressIndicator(
                                  strokeWidth: 4,
                                )
                              : Text(
                                'Guardar',
                                style: TextStyle(color: Colors.white),
                              ),
                              style: ButtonStyle(
                                  padding: MaterialStateProperty.all(
                                      EdgeInsets.symmetric(vertical: 15)),
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromRGBO(19, 81, 216, 1)),
                                  elevation: MaterialStateProperty.all(0),
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)))),
                            ),
                          );
                        },
                      );
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
              top: -10,
              right: -10,
              child: GestureDetector(
                onTap: close,
                child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.redAccent
                ),
                padding: EdgeInsets.all(10),
                child: Icon(Icons.close, color: Colors.white),
              ),
              )
          )
        ],
      ),
    );
        }
      },
    ),
  );
}
