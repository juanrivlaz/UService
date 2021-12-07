import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rxdart/subjects.dart';
import 'package:uService/models/DMS/vehicle_model.dart';
import 'package:uService/models/car_section_model.dart';
import 'package:uService/models/product_model.dart';
import 'package:uService/models/setting_package_model.dart';
import 'package:uService/utils/validators.dart';
import 'package:video_player/video_player.dart';

class ReceptionBloc with Validators {

  BehaviorSubject<int> _typeServiceController = BehaviorSubject<int>();
  BehaviorSubject<String> _customerCommentController = BehaviorSubject<String>();
  BehaviorSubject<String> _technicalCommentController = BehaviorSubject<String>();
  BehaviorSubject<int> _vehicleIdController = BehaviorSubject<int>();
  BehaviorSubject<int> _clientIdController = BehaviorSubject<int>();
  BehaviorSubject<int> _kmServiceController = BehaviorSubject<int>();
  BehaviorSubject<int> _packageIdController = BehaviorSubject<int>();
  BehaviorSubject<List<ProductModel>> _additionalController = BehaviorSubject<List<ProductModel>>();
  BehaviorSubject<List<File>> _imagesController = BehaviorSubject<List<File>>();
  BehaviorSubject<List<CarSectionModel>> _carSectionsController = BehaviorSubject<List<CarSectionModel>>();
  BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>();
  BehaviorSubject<bool> _loadingDataController = BehaviorSubject<bool>();
  BehaviorSubject<bool> _playingPresentationController = BehaviorSubject<bool>();
  BehaviorSubject<VideoPlayerController> _videoplayerController = BehaviorSubject<VideoPlayerController>();
  BehaviorSubject<List<VehicleModel>> _vehiclesController = BehaviorSubject<List<VehicleModel>>();
  BehaviorSubject<VehicleModel> _vehicleController = BehaviorSubject<VehicleModel>();
  BehaviorSubject<String> _resumetextController = BehaviorSubject<String>();
  BehaviorSubject<SettingPackageModel> _packageController = BehaviorSubject<SettingPackageModel>();

  TextEditingController customerCommentController = new TextEditingController();
  TextEditingController technicalCommentController = new TextEditingController();

  Stream<int> get typeServiceStream => _typeServiceController.stream.transform(validNumber);
  Stream<String> get customerCommentStream => _customerCommentController.stream;
  Stream<String> get tecnicalCommentStream => _technicalCommentController.stream;
  Stream<int> get vehicleIdStream => _vehicleIdController.stream.transform(validNumber);
  Stream<int> get clientIdStream => _clientIdController.stream.transform(validNumber);
  Stream<int> get kmServiceStream => _kmServiceController.stream.transform(validNumber);
  Stream<int> get packageIdStream => _packageIdController.stream.transform(validNumber);
  Stream<List<ProductModel>> get additionalStream => _additionalController.stream;
  Stream<List<File>> get imagesStream => _imagesController.stream;
  Stream<List<CarSectionModel>> get carSectionStream => _carSectionsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<bool> get loadingDataStream => _loadingDataController.stream;
  Stream<bool> get playingPresentationStream => _playingPresentationController.stream;
  Stream<VideoPlayerController> get videoPlayerStream => _videoplayerController.stream;
  Stream<List<VehicleModel>> get vehiclesStream => _vehiclesController.stream;
  Stream<VehicleModel> get vehicleStream => _vehicleController.stream;
  Stream<String> get resumetextStream => _resumetextController.stream;
  Stream<SettingPackageModel> get packageStream => _packageController.stream;

  Function(int) get changeTypeService => _typeServiceController.sink.add;
  Function(String) get changeCustomerComment => _customerCommentController.sink.add;
  Function(String) get changeTechnicalComment => _technicalCommentController.sink.add;
  Function(int) get changeVehicleId => _vehicleIdController.sink.add;
  Function(int) get changeClientId => _clientIdController.sink.add;
  Function(int) get changeKmService => _kmServiceController.sink.add;
  Function(int) get changePackageId => _packageIdController.sink.add;
  Function(List<ProductModel>) get changeAdditional => _additionalController.sink.add;
  Function(List<File>) get changeImages => _imagesController.sink.add;
  Function(List<CarSectionModel>) get changeCarSection => _carSectionsController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;
  Function(bool) get changeLoadingData => _loadingDataController.sink.add;
  Function(bool) get changePlayingPresentation => _playingPresentationController.sink.add;
  Function(VideoPlayerController) get changeVideoPlayer => _videoplayerController.sink.add;
  Function(List<VehicleModel>) get changeVehicles => _vehiclesController.sink.add;
  Function(VehicleModel) get changeVehicle => _vehicleController.sink.add;
  Function(String) get changeResumetext => _resumetextController.sink.add;
  Function(SettingPackageModel) get changePackage => _packageController.sink.add;

  int get typeService => _typeServiceController.valueOrNull ?? 0;
  String get customerComment => _customerCommentController.valueOrNull ?? '';
  int get vehicleId => _vehicleIdController.valueOrNull ?? 0;
  int get clientId => _clientIdController.valueOrNull ?? 0;
  int get kmService => _kmServiceController.valueOrNull ?? 0;
  int get packageId => _packageIdController.valueOrNull ?? 0;
  List<ProductModel> get aditional => _additionalController.valueOrNull ?? [];
  List<File> get images => _imagesController.valueOrNull ?? [];
  List<CarSectionModel> get sections => _carSectionsController.valueOrNull ?? [];
  bool get loading => _loadingController.valueOrNull ?? false;
  bool get loadingData => _loadingDataController.valueOrNull ?? false;
  bool get playingPresentation => _playingPresentationController.valueOrNull ?? false;
  VideoPlayerController get videoPlayer => _videoplayerController.valueOrNull ?? VideoPlayerController;
  String get vehicle => _vehicleController.valueOrNull != null ? _vehicleController.value.placas : 'Sin Vehiculo'; 
  String get client => _vehicleController.valueOrNull != null ? _vehicleController.value.client.name : '';
  String get package => _packageController.valueOrNull != null ? _packageController.value.package.name : '';
  double get totalPackage => _packageController.valueOrNull != null ? _packageController.value.getTotalByProduct() : 0;

  ReceptionBloc() {
    this.changeLoading(false);
    this.changeLoadingData(false);
    this.changePlayingPresentation(false);
    this.changeResumetext('Sin Vehiculo');
  }

  void updateResume() {
    var total = this.totalPackage;
    var totalAditionals = this.aditional.fold(0, (value, element) => value + element.price);

    total += totalAditionals;

    var resume = '${this.vehicle} ・ ${this.client} ・ ${this.kmService}KM ・ ${this.package} = ${NumberFormat.currency(symbol: '\$').format(total)}';
    this.changeResumetext(resume);
  }

  dispose() {
    _typeServiceController?.close();
    _customerCommentController?.close();
    _vehicleIdController?.close();
    _clientIdController?.close();
    _kmServiceController?.close();
    _packageIdController?.close();
    _additionalController?.close();
    _imagesController?.close();
    _carSectionsController?.close();
    _loadingController?.close();
    _loadingDataController?.close();
    _technicalCommentController?.close();
    _playingPresentationController?.close();
    _videoplayerController?.close();
    _vehiclesController?.close();
    _vehicleController?.close();
    _resumetextController?.close();
  }
}