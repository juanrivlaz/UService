import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:uService/models/agency_model.dart';
import 'package:uService/pages/agencies/bloc/agency_bloc.dart';
import 'package:uService/pages/agencies/widget/dialog_create.dart';
import 'package:uService/services/rest_service.dart';
import 'package:uService/services/setup_service.dart';
import 'package:uService/utils/general.dart';

class AgenciesProcess {
  BuildContext _context;
  AgencyBloc agencyBloc = new AgencyBloc();
  TextEditingController colorController = new TextEditingController();
  RestService restService = new RestService();

  void init(BuildContext context) {
    this._context = context;
    this.getData();
  }

  double get width {
    return MediaQuery.of(this._context).size.width;
  }

  void openColor() async {
    this.agencyBloc.changeColor(Colors.blue.hex);
    this.colorController.text = Colors.blue.hex;

    return showDialog(
      context: this._context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Seleccionar Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) => {
              this.agencyBloc.changeColor(color.hex),
              this.colorController.text = color.hex
            },
            width: 44,
            height: 44,
            showColorCode: true,
            showColorName: true,
            pickersEnabled: const <ColorPickerType, bool>{
              ColorPickerType.custom: false,
              ColorPickerType.accent: false,
              ColorPickerType.both: false,
              ColorPickerType.bw: false,
              ColorPickerType.primary: false,
              ColorPickerType.wheel: true
            },
          ),
        ),
        actions: <Widget>[
          ElevatedButton(
              onPressed: () => {Navigator.of(this._context).pop()},
              child: Text(
                'Aplicar',
                style: TextStyle(color: Colors.white),
              )),
        ],
      ),
    );
  }

  void uploadLogo() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom, allowedExtensions: ['jpg', 'jpeg', 'png']);

    if (result != null && result.paths.length > 0) {
      String pathImage = result.paths[0] ?? '';
      this.agencyBloc.changeFile(File(pathImage));
    }
  }

  void editAgency(AgencyModel agency) async {

    this.agencyBloc.fromModel(agency);
    this.colorController.text = agency.color;

    await showDialog(
      barrierDismissible: false,
      context: this._context,
      builder: (BuildContext ctx) => dialogCreate(
        this._context,
        this.agencyBloc,
        this.colorController,
        this.uploadLogo,
        this.openColor,
        () => this.update(ctx, agency.id),
        this.closeDialog
      )
    );
  }

  void addAgency() async {

    await showDialog(
       barrierDismissible: false,
        context: this._context,
        builder: (BuildContext ctx) => dialogCreate(
            this._context,
            this.agencyBloc,
            this.colorController,
            this.uploadLogo,
            this.openColor,
            () => this.submit(ctx),
            this.closeDialog
            ));
  }

  void closeDialog() {
    this.agencyBloc.clear();
    Navigator.of(this._context).pop();
  }

  void getData() {
    this.agencyBloc.changeLoadingAgency(true);

    Future.wait([
      this.restService.getStates(),
      this.restService.getBrands(),
      this.restService.getAgencies()
    ]).then((value) {
      this.agencyBloc.changeStates(value[0]);
      this.agencyBloc.changeBrands(value[1]);
      this.agencyBloc.changeListAgency(value[2]);
    }).whenComplete(() => this.agencyBloc.changeLoadingAgency(false));
  }

  void submit(BuildContext ctx) {
    FocusScope.of(ctx).unfocus();

    this.agencyBloc.changeLoading(true);

    this.restService.createAgency(this.agencyBloc.toModel()).then((value) {
      this.agencyBloc.addAgency(value);
      this.agencyBloc.clear();
      this.colorController.text = '';
      Navigator.of(ctx).pop();
    }, onError: (err) => {
      appService<General>().showAlert(this._context, 'Error', err is String ? err : 'Error inesperado, favor de intentar más tarde')
    }).whenComplete(() => {
      this.agencyBloc.changeLoading(false)
    });
  }

  void update(BuildContext ctx, int id) {
    FocusScope.of(ctx).unfocus();

    this.agencyBloc.changeLoading(true);

    var agency = this.agencyBloc.toModel();
    agency.id = id;

    this.restService.updateAgency(agency).then((value) {
      var listAgency = this.agencyBloc.listAgency;
      var index = listAgency.indexWhere((element) => element.id == agency.id);

      if (index > 0) {
        this.agencyBloc.listAgency[index] = value;
        this.agencyBloc.changeListAgency(this.agencyBloc.listAgency);
      }

      this.agencyBloc.clear();
      this.colorController.text = '';
      Navigator.of(ctx).pop();
    }, onError: (err) => {
      appService<General>().showAlert(this._context, 'Error', err is String ? err : 'Error inesperado, favor de intentar más tarde')
    }).whenComplete(() => {
      this.agencyBloc.changeLoading(false)
    });
  }
}
