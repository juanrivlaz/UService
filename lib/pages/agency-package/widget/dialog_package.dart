import 'package:flutter/material.dart';
import 'package:uService/pages/agency-package/bloc/package_bloc.dart';
import 'package:uService/pages/agency-package/widget/package/input_color.dart';
import 'package:uService/pages/agency-package/widget/package/input_name.dart';

Widget dialogPackage(
  BuildContext context,
  PackageBloc bloc,
  TextEditingController colorController,
  Function openColor,
  Function close,
  Function submit
) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15),
    ),
    child: Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 400,
            height: 365,
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
                          'AGREGAR PAQUETE',
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
                      child: inputPackageName(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Color',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputPackageColor(bloc, colorController, openColor),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      width: double.infinity,
                      child: StreamBuilder(
                        stream: bloc.loadingStream,
                        builder: (BuildContext ctxLoading, AsyncSnapshot shpLoading) {
                          return StreamBuilder(
                        stream: bloc.formValidStream,
                        builder: (BuildContext ctx, AsyncSnapshot snapshot) {
                          return Opacity(
                            opacity: shpLoading.hasData && !shpLoading.data && snapshot.hasData && snapshot.data ? 1 : .4,
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
    ),
  );
}