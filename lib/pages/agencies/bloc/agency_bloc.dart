import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:uService/models/agency_model.dart';
import 'package:uService/models/brand_model.dart';
import 'package:uService/models/state_model.dart';
import 'package:uService/utils/validators.dart';

class AgencyBloc with Validators
{
  TextEditingController nameController = new TextEditingController();
  TextEditingController apiController = new TextEditingController();

  BehaviorSubject<String> _nameController   = BehaviorSubject<String>();
  BehaviorSubject<int> _brandController  = BehaviorSubject<int>();
  BehaviorSubject<int> _cityController   = BehaviorSubject<int>();
  BehaviorSubject<int> _stateController  = BehaviorSubject<int>();
  BehaviorSubject<String> _colorController  = BehaviorSubject<String>();
  BehaviorSubject<String> _apiController    = BehaviorSubject<String>();
  BehaviorSubject<File> _fileController   = BehaviorSubject<File>();
  BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>();
  BehaviorSubject<List<BrandModel>> _brandsController = BehaviorSubject<List<BrandModel>>();
  BehaviorSubject<List<StateModel>> _statesController = BehaviorSubject<List<StateModel>>();
  BehaviorSubject<bool> _loadingDataController = BehaviorSubject<bool>();
  BehaviorSubject<bool> _loadingAgencyController = BehaviorSubject<bool>();
  BehaviorSubject<String> _filterController = BehaviorSubject<String>();
  final _listAgencyController       = BehaviorSubject<List<AgencyModel>>();

  Stream<String> get nameStream   => _nameController.stream.transform(validateEmpty);
  Stream<int> get brandStream  => _brandController.stream.transform(validNumber);
  Stream<int> get cityStream   => _cityController.stream.transform(validNumber);
  Stream<int> get stateStream  => _stateController.stream.transform(validNumber);
  Stream<String> get colorStream  => _colorController.stream.transform(validHexadecimal);
  Stream<String> get apiStream    => _apiController.stream.transform(validateEmpty);
  Stream<File>   get fileStream   => _fileController.stream.transform(validFileEmpty);
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<List<AgencyModel>> get listAgencyStream => _listAgencyController.stream;
  Stream<List<BrandModel>> get brandsStream => _brandsController.stream;
  Stream<List<StateModel>> get statesStream => _statesController.stream;
  Stream<bool> get loadingDataStream => _loadingDataController.stream;
  Stream<bool> get loadingAgencyStream => _loadingAgencyController.stream;
  Stream<String> get filterStream => _filterController.stream;
  Stream<bool> get fromValidStream => Rx.combineLatest7(
    this.nameStream, 
    this.brandStream, 
    this.cityStream, 
    this.stateStream, this.colorStream, this.apiStream, this.fileStream, (a, b, c, d, e, f, g) => true);

  Function(String) get changeName   => _nameController.sink.add;
  Function(int) get changeBrand  => _brandController.sink.add;
  Function(int) get changeCity   => _cityController.sink.add;
  Function(int) get changeState  => _stateController.sink.add;
  Function(String) get changeColor  => _colorController.sink.add;
  Function(String) get changeApi    => _apiController.sink.add;
  Function(File)   get changeFile   => _fileController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;
  Function(List<AgencyModel>) get changeListAgency => _listAgencyController.sink.add;
  Function(List<BrandModel>) get changeBrands => _brandsController.sink.add;
  Function(List<StateModel>) get changeStates => _statesController.sink.add;
  Function(bool) get changeLoadingData => _loadingDataController.sink.add;
  Function(bool) get changeLoadingAgency => _loadingAgencyController.sink.add;
  Function(String) get changeFilter => _filterController.sink.add;

  String get name   => _nameController.valueOrNull ?? '';
  int get brand  => _brandController.valueOrNull ?? 0;
  int get city   => _cityController.valueOrNull ?? 0;
  int get state  => _stateController.valueOrNull ?? 0;
  String get color  => _colorController.valueOrNull ?? '';
  String get api    => _apiController.valueOrNull ?? '';
  File   get file   => _fileController.valueOrNull;
  bool get loading => _loadingController.valueOrNull;
  List<AgencyModel> get listAgency => _listAgencyController.valueOrNull ?? [];
  List<BrandModel> get brands => _brandsController.valueOrNull;
  List<StateModel> get states => _statesController.valueOrNull;
  bool get loadingData => _loadingDataController.valueOrNull;
  bool get loadingAgency => _loadingAgencyController.valueOrNull;
  String get filter => _filterController.valueOrNull;

  Map<String, String> toJson() {
    return {
      'name': this.name,
      'brand_id': this.brand.toString(),
      'city_id': this.city.toString(),
      'state_id': this.state.toString(),
      'color': this.color,
      'api_url': this.api
    };
  }

  AgencyModel toModel() {
    AgencyModel model = new AgencyModel();
    model.name = this.name;
    model.brandId = this.brand;
    model.cityId = this.city;
    model.stateId = this.state;
    model.color = this.color;
    model.apiUrl = this.api;
    model.logo = this.file;

    return model;
  }

  void fromModel(AgencyModel agency) {
    this.changeName(agency.name);
    this.changeBrand(agency.brandId);
    this.changeCity(agency.cityId);
    this.changeState(agency.stateId);
    this.changeColor(agency.color);
    this.changeApi(agency.apiUrl);
    this.nameController.text = agency.name;
    this.apiController.text = agency.apiUrl;
    this.changeFile(new File(''));
  }

  void addAgency(AgencyModel agency) {
    List<AgencyModel> currentValue = this.listAgency;
    currentValue.add(agency);

    this.changeListAgency(currentValue);
  }

  AgencyBloc() {
    this.changeLoading(false);
  }

  void clear() {
    this._nameController   = BehaviorSubject<String>();
    this._brandController  = BehaviorSubject<int>();
    this._cityController   = BehaviorSubject<int>();
    this._stateController  = BehaviorSubject<int>();
    this._colorController  = BehaviorSubject<String>();
    this._apiController    = BehaviorSubject<String>();
    this._fileController   = BehaviorSubject<File>();
    this.nameController.text = '';
    this.apiController.text = '';
    this.changeLoading(false);
  }

  void dispose()
  {
    _nameController?.close();
    _brandController?.close();
    _cityController?.close();
    _stateController?.close();
    _colorController?.close();
    _apiController?.close();
    _fileController?.close();
    _loadingController?.close();
    _listAgencyController?.close();
    _brandsController?.close();
    _statesController?.close();
    _loadingDataController?.close();
    _loadingAgencyController?.close();
    _filterController?.close();
  }

}