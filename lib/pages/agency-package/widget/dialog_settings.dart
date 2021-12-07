import 'package:flutter/material.dart';
import 'package:uService/pages/agency-package/bloc/setting_bloc.dart';
import 'package:uService/pages/agency-package/widget/setting/button_setting_submit.dart';
import 'package:uService/pages/agency-package/widget/setting/input_setting_km_every.dart';
import 'package:uService/pages/agency-package/widget/setting/input_setting_km_initial.dart';
import 'package:uService/pages/agency-package/widget/setting/input_setting_year_finish.dart';
import 'package:uService/pages/agency-package/widget/setting/input_setting_year_initial.dart';

Widget dialogSetting(
  BuildContext context,
  SettingBloc bloc,
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
            height: 570,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 6),
                      child: Center(
                        child: Text(
                          'AGREGAR CONFIGURACIÓN',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w700,
                              fontSize: 19),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Center(
                        child: Text(
                          'Los kilometrajes trendran que ser multiplos de mil',
                          style: TextStyle(
                              color: Colors.black38,
                              fontWeight: FontWeight.w700,
                              fontSize: 12),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: Text('AÑO INICIAL',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputSettingYearInitial(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('AÑO FINAL',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputSettingYearFinish(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('KM INICIAL',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputSettingKmInitial(bloc),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 12),
                      child: Text('INTERVALOS (KM)',
                          style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.w600)),
                    ),
                    Container(
                      child: inputSettingKmEvery(bloc),
                    ),
                    SizedBox(height: 20),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      width: double.infinity,
                      child: buttonSettingSubmit(bloc, submit),
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
    )
  );
}