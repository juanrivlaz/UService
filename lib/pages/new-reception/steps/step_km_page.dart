import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';

double width(BuildContext context) {

  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.width * .9;
  }

  return MediaQuery.of(context).size.width > 700
      ? MediaQuery.of(context).size.width * .55
      : MediaQuery.of(context).size.width;
}

Widget km(BuildContext context, ReceptionBloc bloc, Function(int) getSettingsPackage) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(25),
          child: Text(
            'KILOMETRAJE',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          width: width(context),
          child: StreamBuilder(
            stream: bloc.kmServiceStream,
            builder: (BuildContext ctxkm, AsyncSnapshot snpkm) {
              return Wrap(
            spacing: 25,
            runSpacing: 25,
            alignment: WrapAlignment.center,
            children: new List<int>.generate(30, (index) => index + 1).map((e) => TextButton(
                style: TextButton.styleFrom(
                  textStyle: const TextStyle(fontSize: 20),
                  elevation: 2,
                  backgroundColor: snpkm.hasData && snpkm.data == (e * 10000) ? Colors.blue[100] : Colors.white,
                  padding: EdgeInsets.all(12),
                  side: BorderSide(color: snpkm.hasData && snpkm.data == (e * 10000) ? Colors.blue[800] : Colors.black38, width: 1)
                ),
                onPressed: () {
                  bloc.changeKmService(e * 10000);
                  bloc.updateResume();
                  getSettingsPackage(e * 10000);
                },
                child: Text('${NumberFormat.currency(symbol: '', decimalDigits: 0).format(e * 10000)} KM', style: TextStyle(fontSize: 22, color: Colors.black87)),
              )).toList()
          );
            },
          ),
        )
      ],
    ),
  );
}
