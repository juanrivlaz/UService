import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:uService/models/agency_model.dart';
import 'package:uService/models/product_model.dart';
import 'package:uService/models/setting_package_model.dart';
import 'package:uService/pages/agency-package/bloc/agency_package_bloc.dart';
import 'package:uService/pages/agency-package/bloc/package_bloc.dart';
import 'package:uService/pages/agency-package/bloc/setting_bloc.dart';
import 'package:uService/pages/agency-package/widget/dialog_package.dart';
import 'package:uService/pages/agency-package/widget/dialog_products.dart';
import 'package:uService/pages/agency-package/widget/dialog_settings.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/rest_service.dart';
import 'package:uService/services/setup_service.dart';

class AgencyPackageProcess {
  BuildContext _context;
  PackageBloc packageBloc = new PackageBloc();
  SettingBloc settingBloc = new SettingBloc();
  AgencyPackageBloc agencyPackageBloc = new AgencyPackageBloc();
  TextEditingController colorController = new TextEditingController();
  List<ProductModel> products = [];
  int agencyId;

  void init(BuildContext ctx, AgencyModel agency) {
    this._context = ctx;
    this.agencyPackageBloc.chagenPackage(agency.packages);
    this.agencyId = agency.id;
    this.getProduct(agency.id);
  }

  void getProduct(int agencyId) {
    this.agencyPackageBloc.changeLoadingData(true);
    appService<RestService>().getProductsByAgency(agencyId).then((value) {
      this.products = value;
    }).whenComplete(() {
      this.agencyPackageBloc.changeLoadingData(false);
    });
  }

  void openColor() async {
    this.packageBloc.changeColor(Colors.blue.hex);
    this.colorController.text = Colors.blue.hex;

    return showDialog(
      context: this._context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Seleccionar Color'),
        content: SingleChildScrollView(
          child: ColorPicker(
            color: Colors.blue,
            onColorChanged: (Color color) => {
              this.packageBloc.changeColor(color.hex),
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

  void addPackage() async {
    await showDialog(
      context: this._context,
      builder: (BuildContext ctx) => dialogPackage(
        this._context,
        this.packageBloc,
        this.colorController,
        this.openColor,
        this.closeDialog,
        () => {
          this.submitPackage(ctx)
        }
      )
    );
  }

  void closeDialog() {
    Navigator.of(this._context).pop();
  }

  void addSetting(int indexPackage) async {
    await showDialog(
      context: this._context,
      builder: (BuildContext ctx) => dialogSetting(
        ctx,
        this.settingBloc,
        this.closeDialog,
        () => this.submitSetting(ctx, indexPackage)
      )
    );
  }

  void editSetting(int indexPackage, int indexSetting, SettingPackageModel setting) async {
    this.settingBloc.setToModel(setting);

    await showDialog(
      context: this._context,
      builder: (BuildContext ctx) => dialogSetting(
        ctx, 
        this.settingBloc, 
        this.closeDialog, 
        () => this.saveEditSetting(ctx, indexPackage, indexSetting)
      )
    );
  }

  void addProducts(int indexPackage, int indexSetting, SettingPackageModel setting) async {
    this.settingBloc.setToModel(setting);

    await showDialog(
      context: this._context,
      builder: (BuildContext ctx) => dialogProducts(
        ctx,
        this.settingBloc,
        this.closeDialog,
        () => this.submitProducts(ctx, indexPackage, indexSetting),
        products: this.products
      )
    );
  }

  void submitProducts(BuildContext ctx, int indexPackage, int indexSetting) {
    var packages = this.agencyPackageBloc.packages;
    packages[indexPackage].settings[indexSetting].products = this.settingBloc.products;

    this.agencyPackageBloc.chagenPackage(packages);
    this.settingBloc.clear();
    Navigator.of(ctx).pop();
  }

  void submitPackage(BuildContext ctx) {
    var packages = this.agencyPackageBloc.packages;
    packages.add(this.packageBloc.toModel());

    this.agencyPackageBloc.chagenPackage(packages);

    this.packageBloc.clear();
    this.colorController.text = '';

    Navigator.of(ctx).pop();
  }

  void saveEditSetting(BuildContext ctx, int indexPackage, int indexSetting) {
    var packages = this.agencyPackageBloc.packages;
    packages[indexPackage].settings[indexSetting] = this.settingBloc.toModel();

    this.agencyPackageBloc.chagenPackage(packages);
    this.settingBloc.clear();
    Navigator.of(ctx).pop();
  }

  void submitSetting(BuildContext ctx, int indexPackage) {
    this.settingBloc.changeLoading(true);
    var packages = this.agencyPackageBloc.packages;
    packages[indexPackage].settings.add(this.settingBloc.toModel());

    this.agencyPackageBloc.chagenPackage(packages);

    this.settingBloc.clear();
    Navigator.of(ctx).pop();
  }

  void deletePackage(int indexPackage) {
    var packages = this.agencyPackageBloc.packages;
    packages.removeAt(indexPackage);

    this.agencyPackageBloc.chagenPackage(packages);
  }

  void deleteSetting(int indexPackage, int indexSetting) {
    var packages = this.agencyPackageBloc.packages;
    
    packages.asMap().entries.forEach((element) {
      if (element.key == indexPackage) {
        element.value.settings.removeAt(indexSetting);
      }
    });

    this.agencyPackageBloc.chagenPackage(this.agencyPackageBloc.packages);
  }

  void deleteProduct(int indexPackage, int indexSetting, int indexProduct) {
    var packages = this.agencyPackageBloc.packages;
    var setting = packages[indexPackage].settings[indexSetting];
    var products = setting.products;
    products.removeAt(indexProduct);

    packages[indexPackage].settings[indexSetting].products = products;

    this.agencyPackageBloc.chagenPackage(packages);
  }

  void submit() {
    this.agencyPackageBloc.changeLoadingSave(true);
    var packages = this.agencyPackageBloc.packages;
    
    appService<RestService>().saveAgencyPackages(packages, this.agencyId).then((value) {
      appService<NavigationService>().goBack();
    }, onError: (err) => {
      ScaffoldMessenger.of(this._context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            err is String ? err : 'Error al guardar la información'),
      ))
    }).whenComplete(() => this.agencyPackageBloc.changeLoadingSave(false));
  }

  Iterable selectSettingsByKm(int km) {
    var firstPackage = agencyPackageBloc.packages.first;
    return firstPackage.settings.where((setting) => setting.kmInitial == km || (km % setting.everyKm == setting.kmInitial % setting.everyKm));
  }
}