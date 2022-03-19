import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uService/models/setting_package_model.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';
import 'package:uService/pages/new-reception/widget/item_of_package.dart';
import 'package:uService/utils/hex_color.dart';

double width(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.width * .9;
  }

  return MediaQuery.of(context).size.width > 700
      ? MediaQuery.of(context).size.width * .55
      : MediaQuery.of(context).size.width;
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Widget carPackage(BuildContext context, ReceptionBloc bloc, Function next,
    {bool isRecommended, SettingPackageModel package}) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Color.fromRGBO(250, 250, 251, 1),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          offset: Offset(1.0, 1.0), //(x,y)
          blurRadius: 18.0,
        ),
      ],
    ),
    width: MediaQuery.of(context).orientation == Orientation.portrait
        ? width(context)
        : fullWidth(context) / (isRecommended ? 3 : 4),
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.all(24),
          color: HexColor.fromHex(package.package.color),
          height: 70,
          child: Center(
            child: Text(package.package.name,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 20)),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 30),
          color: HexColor.fromHex(package.package.color).withOpacity(.5),
          height: 120,
          child: Center(
            child: Text(
                NumberFormat.currency(symbol: '\$ ')
                    .format(package.getTotalByProduct()),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white)),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Column(
          children: package.products
              .map((product) => Column(
                    children: [
                      itemOfPackage(context,
                          isPrincipal: isRecommended,
                          name: product.name,
                          width: MediaQuery.of(context).orientation ==
                                  Orientation.portrait
                              ? width(context)
                              : fullWidth(context) / (isRecommended ? 3 : 4)),
                      Divider()
                    ],
                  ))
              .toList(),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 30),
          child: TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all(
                    EdgeInsets.symmetric(vertical: 5, horizontal: 45)),
                backgroundColor: MaterialStateProperty.all(HexColor.fromHex(package.package.color)),
              ),
              child: Text(
                'Seleccionar',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              onPressed: () {
                bloc.changePackage(package);
                bloc.updateResume();
                next();
              }),
        )
      ],
    ),
  );
}
