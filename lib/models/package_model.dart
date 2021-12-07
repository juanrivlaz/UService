import 'package:uService/models/setting_package_model.dart';
import 'package:uuid/uuid.dart';

class PackageModel {
  String uuid;
  int id;
  String name;
  String color;
  List<SettingPackageModel> settings;

  PackageModel() {
    this.uuid = Uuid().v1();
    this.id = 0;
    this.name = '';
    this.color = '';
    this.settings = [];
  }

  factory PackageModel.fromJson(Map<String, dynamic> json) {
    PackageModel package = new PackageModel();

    package.id = int.parse((json['id'] ?? 0).toString());
    package.name = json['name'] ?? '';
    package.color = json['color'] ?? '';
    package.settings = ((json['settings'] ?? []) as Iterable).map((setting) => SettingPackageModel.fromJson(setting)).toList();

    return package;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': this.id.toString(),
      'name': this.name,
      'color': this.color,
      'settings': this.settings.map((setting) => setting.toJson()).toList()
    };
  }
}