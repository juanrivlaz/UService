import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:uService/models/product_model.dart';
import 'package:uService/models/setting_package_model.dart';
import 'package:uService/utils/validators.dart';

class SettingBloc with Validators {

  BehaviorSubject<int> _yearInitialController = BehaviorSubject<int>();
  BehaviorSubject<int> _yearFinishController = BehaviorSubject<int>();
  BehaviorSubject<int> _kmInitialController = BehaviorSubject<int>();
  BehaviorSubject<int> _everyKmController = BehaviorSubject<int>();
  BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>();
  BehaviorSubject<List<ProductModel>> _productsController = BehaviorSubject<List<ProductModel>>();

  TextEditingController yearInitialTextController = new TextEditingController(); 
  TextEditingController yearFinishTextController = new TextEditingController(); 
  TextEditingController kmInitialTextController = new TextEditingController(); 
  TextEditingController everyKmTextController = new TextEditingController(); 

  Stream<int> get yearInitialStream => _yearInitialController.stream.transform(validNumber);
  Stream<int> get yearFinishStream => _yearFinishController.stream.transform(validNumber);
  Stream<int> get kmInitialStream => _kmInitialController.stream.transform(validNumber);
  Stream<int> get everyKmStream => _everyKmController.stream.transform(validNumber);
  Stream<List<ProductModel>> get productStream => _productsController.stream;
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<bool> get formValidStream => Rx.combineLatest4(yearInitialStream, yearFinishStream, kmInitialStream, everyKmStream, (a, b, c, d) => true);

  Function(int) get changeYearInitial => _yearInitialController.sink.add;
  Function(int) get changeYearFinish => _yearFinishController.sink.add;
  Function(int) get changeKmInitial => _kmInitialController.sink.add;
  Function(int) get changeEveryKm => _everyKmController.sink.add;
  Function(List<ProductModel>) get changeProducts => _productsController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  int get yearInitial => _yearInitialController.valueOrNull ?? 0;
  int get yearFinish => _yearFinishController.valueOrNull ?? 0;
  int get kmInitial => _kmInitialController.valueOrNull ?? 0;
  int get everyKm => _everyKmController.valueOrNull ?? 0;
  List<ProductModel> get products => _productsController.valueOrNull ?? [];

  SettingBloc() {
    this.changeLoading(false);
  }

  void clear() {
    this._yearInitialController = BehaviorSubject<int>();
    this._yearFinishController = BehaviorSubject<int>();
    this._kmInitialController = BehaviorSubject<int>();
    this._everyKmController = BehaviorSubject<int>();
    this.changeProducts([]);
    this.changeLoading(false);

    this.yearInitialTextController.text = ''; 
    this.yearFinishTextController.text = ''; 
    this.kmInitialTextController.text = ''; 
    this.everyKmTextController.text = ''; 
  }

  SettingPackageModel toModel() {
    SettingPackageModel model = new SettingPackageModel();

    model.yearInitial = this.yearInitial;
    model.yearFinish = this.yearFinish;
    model.kmInitial = this.kmInitial;
    model.everyKm = this.everyKm;
    model.products = this.products;

    this.yearInitialTextController.text = this.yearInitial.toString();
    this.yearFinishTextController.text = this.yearFinish.toString();
    this.kmInitialTextController.text = this.kmInitial.toString();
    this.everyKmTextController.text = this.everyKm.toString();

    return model;
  }

  void setToModel(SettingPackageModel setting) {
    this.changeYearInitial(setting.yearInitial);
    this.changeYearFinish(setting.yearFinish);
    this.changeKmInitial(setting.kmInitial);
    this.changeEveryKm(setting.everyKm);
    this.changeProducts(setting.products);

    this.yearInitialTextController.text = setting.yearInitial.toString();
    this.yearFinishTextController.text = setting.yearFinish.toString();
    this.kmInitialTextController.text = setting.kmInitial.toString();
    this.everyKmTextController.text = setting.everyKm.toString();
  }

  void dispose() {
    this._everyKmController?.close();
    this._kmInitialController?.close();
    this._loadingController?.close();
    this._yearFinishController?.close();
    this._yearInitialController?.close();
    this._productsController?.close();
  }
}