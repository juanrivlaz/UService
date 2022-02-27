import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/models/setting_package_model.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';
import 'package:uService/pages/new-reception/widget/car_package.dart';

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

Widget package(
  BuildContext context,
  ReceptionBloc bloc,
  List<SettingPackageModel> packages,
  Function next
) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 24),
          child: Text(
            'PAQUETES',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          padding: EdgeInsets.symmetric(vertical: 24),
          child: Wrap(
            spacing: 24,
            runSpacing: 24,
            alignment: WrapAlignment.spaceBetween,
            direction:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? Axis.vertical
                    : Axis.horizontal,
            children: packages.map((package) => carPackage(
              context, 
              bloc,
              next,
              isRecommended: package.package.name == 'INTERMEDIO',
              package: package,
            )).toList()
          ),
        )
      ],
    ),
  );
}
