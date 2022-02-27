import 'package:flutter/material.dart';
import 'package:uService/pages/new-reception/bloc/client_bloc.dart';
import 'package:uService/pages/new-reception/widget/input_text.dart';

Widget dialogCreateClinet(
  BuildContext context,
  ClientBloc bloc,
  Function submit,
  Function close
) {
  return Dialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15)
    ),
    child: Container(
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
                        child: Text('Cliente', style: TextStyle(
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontSize: 19
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text('RFC', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      child: inputText(
                        stream: bloc.rfcStream,
                        change: bloc.changeRfc,
                        controller: TextEditingController()),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Nombre', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      child: inputText(
                        stream: bloc.nameStream,
                        change: bloc.changeName,
                        controller: TextEditingController()),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Dirección', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      child: inputText(
                        stream: bloc.addressStream,
                        change: bloc.changeAddress,
                        controller: TextEditingController()),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Colonia', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      child: inputText(
                        stream: bloc.colonyStream,
                        change: bloc.changeColony,
                        controller: TextEditingController()),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Ciudad', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      child: inputText(
                        stream: bloc.cityStream,
                        change: bloc.changeCity,
                        controller: TextEditingController()),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Estado', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      child: inputText(
                        stream: bloc.stateStream,
                        change: bloc.changeState,
                        controller: TextEditingController()),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('Codigo Postal', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.w600),),
                    ),
                    Container(
                      child: inputText(
                        stream: bloc.postcodeStream,
                        change: bloc.changePostcode,
                        controller: TextEditingController()),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      width: double.infinity,
                      child: StreamBuilder(
                        stream: bloc.fromValidStream,
                        builder: (BuildContext ctxForm, AsyncSnapshot snpForm) {
                          bool valid = snpForm.hasData && snpForm.data;

                          return StreamBuilder(
                            stream: bloc.loadingStream,
                            builder: (BuildContext ctxLoading, AsyncSnapshot snpLoading) {
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
                            },
                          );
                        },
                      ),
                    ),
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
    ),
  );
}