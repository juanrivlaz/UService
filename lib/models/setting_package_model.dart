import 'package:uService/models/package_model.dart';
import 'package:uService/models/product_model.dart';
import 'package:uuid/uuid.dart';

class SettingPackageModel {
  String uuid;
  int id;
  int yearInitial;
  int yearFinish;
  int kmInitial;
  int everyKm;
  List<ProductModel> products;
  PackageModel package;

  SettingPackageModel() {
    this.uuid = Uuid().v1();
    this.id = 0;
    this.yearInitial = 0;
    this.yearFinish = 0;
    this.kmInitial = 0;
    this.everyKm = 0;
    this.products = [];
    this.package = PackageModel.fromJson({});
  }

  factory SettingPackageModel.fromJson(Map<String, dynamic> json) {
    SettingPackageModel setting = new SettingPackageModel();

    setting.id = int.parse((json['id'] ?? 0).toString());
    setting.yearInitial = int.parse((json['initial_year'] ?? 0).toString());
    setting.yearFinish = int.parse((json['final_year'] ?? 0).toString());
    setting.kmInitial = int.parse((json['km_initial'] ?? 0).toString());
    setting.everyKm = int.parse((json['every_km'] ?? 0).toString());
    setting.products = ((json['products'] ?? []) as Iterable).map((product) => ProductModel.fromJson(product)).toList();
    setting.package = PackageModel.fromJson(json['package'] ?? {});

    return setting;
  }

  double getTotalByProduct() {
    return this.products.fold(0, (value, element) => value + element.price);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id.toString(),
      'initial_year': this.yearInitial.toString(),
      'final_year': this.yearFinish.toString(),
      'km_initial': this.kmInitial.toString(),
      'every_km': this.everyKm.toString(),
      'products': this.products.map((product) => product.toJson()).toList()
    };
  }
}