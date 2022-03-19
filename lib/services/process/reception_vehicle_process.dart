import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uService/models/DMS/marca_model.dart';
import 'package:uService/models/car_section_model.dart';
import 'package:uService/models/product_model.dart';
import 'package:uService/models/setting_package_model.dart';
import 'package:uService/models/type_service_model.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';
import 'package:uService/pages/new-reception/widget/dialog_presentation_product.dart';
import 'package:uService/services/rest_service.dart';

class ReceptionVehicleProcess {

  final ImagePicker imagePicker = new ImagePicker();
  ReceptionBloc bloc = new ReceptionBloc();
  BuildContext _context;
  List<File> images = [];
  List<TypeServiceModel> typesService = [];
  List<ProductModel> products = [];
  List<CarSectionModel> carSections = [];
  List<SettingPackageModel> packages = [];
  List<MarcaModel> marcas = [];
  RestService restService = new RestService();

  void init(BuildContext context) {
    this._context = context;
    this.getData();
  }

  void getData() {
    this.bloc.changeLoadingData(true);

    Future.wait([
      this.restService.getTypesService(), 
      this.restService.getProductsByAgency(1),
      this.restService.getCarSections(),
      this.restService.getVehicles(),
      this.restService.getMarcas()
    ]).then((value) {
      this.typesService = value[0];
      this.products = value[1];
      this.carSections = value[2];
      this.bloc.changeVehicles(value[3]);
      this.marcas = value[4];
      this.bloc.changeClients(value[5]);
    }).whenComplete(() => this.bloc.changeLoadingData(false));
  }

  void showPresentation(String link) async {

    await showDialog(
      context: this._context,
      builder: (BuildContext ctx) => dialogPresentationProduct(
        this._context,
        () => Navigator.of(this._context).pop(),
        link,
        this.bloc
      )
    );
  }

  Future<void> captureImage() async {
    
    XFile image = await this.imagePicker.pickImage(source: ImageSource.camera, imageQuality: 50, preferredCameraDevice: CameraDevice.rear);

    if (image != null) {
      var images = this.bloc.images;
      images.add(File(image.path));

      this.bloc.changeImages(images);
    }
  }

  void getSettingsPackage(int km) {
    this.restService.getSettingPackageByKM(km).then((value) {
      value.sort((a, b) => a.getTotalByProduct().compareTo(b.getTotalByProduct()));
      
      this.packages = value;
    });
  }


}