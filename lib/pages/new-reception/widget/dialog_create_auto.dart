import 'package:flutter/material.dart';
import 'package:uService/models/DMS/marca_model.dart';
import 'package:uService/models/DMS/modelo_model.dart';
import 'package:uService/models/input_select.dart';
import 'package:uService/pages/new-reception/bloc/auto_bloc.dart';
import 'package:uService/widgets/input_select.dart';
import 'package:uService/widgets/input_text.dart';

Widget dialogCreateAuto(
  BuildContext context,
  AutoBloc bloc,
  List<MarcaModel> marcas,
  Function submit,
  Function close
) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    ),
    child: StreamBuilder(
      stream: bloc.loadingDataStream,
      builder: (BuildContext ctx, AsyncSnapshot snp) {
        if (snp.hasData && snp.data) {
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
                              child: Text('Vehiculo', style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.w700,
                                fontSize: 19
                              ),),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 12),
                            child: Text('Serie', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                          ),
                          Container(
                            child: inputText(
                              stream: bloc.serieStream,
                              change: bloc.changeSerie,
                              controller: TextEditingController()),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Placas', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                          ),
                          Container(
                            child: inputText(
                              stream: bloc.placaStream,
                              change: bloc.changePlaca,
                              controller: TextEditingController()),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Color', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                          ),
                          Container(
                            child: inputText(
                              stream: bloc.colorStream,
                              change: bloc.changeColor,
                              controller: TextEditingController()),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Marca', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                          ),
                          Container(
                            child: inputSelect(
                              stream: bloc.marcaStream,
                              change: bloc.changeMarca,
                              label: 'Seleccione una marca',
                              items: marcas.map((marca) => InputSelect(value: marca.id, label: marca.description)).toList()
                            )
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Modelo', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                          ),
                          StreamBuilder(
                            stream: bloc.marcaStream,
                            builder: (BuildContext ctx, AsyncSnapshot<int> snp) {
                              return Container(
                                child: inputSelect(
                                  stream: bloc.modelStream,
                                  change: bloc.changeModel,
                                  label: 'Seleccione un modelo',
                                  items: getModelos(marcas, snp.data).map((model) => InputSelect(value: model.id, label: model.description)).toList()
                                ),
                              );
                            },
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Motor', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                          ),
                          Container(
                            child: inputText(
                              stream: bloc.motorStream,
                              change: bloc.changeMotor,
                              controller: TextEditingController()),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Año', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                          ),
                          Container(
                            child: inputText(
                              stream: bloc.yearStream,
                              change: (String value) {
                                var num =int.tryParse(value);
                                if (num != null) {
                                  bloc.changeYear(num);
                                }
                              },
                              controller: TextEditingController()),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 12),
                            child: Text('Cilindros', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                          ),
                          Container(
                            child: inputText(
                              stream: bloc.cilindrosStream,
                              change: bloc.changeCilindros,
                              controller: TextEditingController()),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 24),
                            width: double.infinity,
                            child: StreamBuilder(
                                  stream: bloc.formValidStream,
                                  builder: (BuildContext ctxForm, AsyncSnapshot snpForm) {
                                    bool valid = snpForm.hasData && snpForm.data;

                                    return StreamBuilder(
                                      stream: bloc.loadingStream,
                                      builder: (BuildContext ctxLoading, AsyncSnapshot<bool> snpLoading) {
                                        bool loading = snpLoading.hasData && snpLoading.data;

                                        return Opacity(
                                          opacity: valid && !loading ? 1 : .5,
                                          child: ElevatedButton(
                                            onPressed: valid && !loading ? submit : null,
                                            child: !loading ? Text('Guardar', style: TextStyle(color: Colors.white)) : CircularProgressIndicator(),
                                            style: ButtonStyle(
                                              padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(vertical: 15)
                                              ),
                                              backgroundColor: MaterialStateProperty.all(
                                                Color.fromRGBO(19, 81, 216, 1)
                                              ),
                                              elevation: MaterialStateProperty.all(0),
                                              shape: MaterialStateProperty.all(
                                                RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(20)
                                                )
                                              )
                                            ),
                                          ),
                                        );
                                      }
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
                  child: IconButton(
                    color: Colors.redAccent,
                    onPressed: close,
                    icon: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.redAccent
                      ),
                      child: Icon(Icons.close, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          );
        }
      },
    ),
  );
}

List<ModeloModel> getModelos(List<MarcaModel> marcas, int idMarca) {

  if (idMarca == null) return [];

  MarcaModel marca = marcas.firstWhere((element) => element.id == idMarca);
  marca.models.sort((a, b) => a.description.compareTo(b.description));

  return marca.models;

}