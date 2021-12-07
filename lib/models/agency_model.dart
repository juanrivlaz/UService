import 'dart:io';

import 'package:uService/models/brand_model.dart';
import 'package:uService/models/city_model.dart';
import 'package:uService/models/package_model.dart';
import 'package:uService/models/state_model.dart';

class AgencyModel {
  int id;
  String name;
  int brandId;
  int cityId;
  int stateId;
  String color;
  String apiUrl;
  File logo;
  BrandModel brand;
  StateModel state;
  CityModel city;
  List<PackageModel> packages;

  AgencyModel() {
    this.name = '';
    this.brandId = 0;
    this.cityId = 0;
    this.stateId = 0;
    this.color = 'FFFFFF';
    this.brand = BrandModel.fromJson({});
    this.state = StateModel.fromJson({});
    this.city = CityModel.fromJson({});
    this.packages = [];
  }

  factory AgencyModel.fromJson(Map<String, dynamic> json) {
    AgencyModel agency = new AgencyModel();

    agency.id = int.parse((json['id'] ?? 0).toString());
    agency.name = json['name'] ?? '';
    agency.brandId = int.parse((json['brand_id'] ?? 0).toString());
    agency.cityId = int.parse((json['city_id'] ?? 0).toString());
    agency.stateId = int.parse((json['state_id'] ?? 0).toString());
    agency.color = json['color'] ?? '';
    agency.apiUrl = json['api_url'] ?? '';
    agency.brand = BrandModel.fromJson(json['brand'] ?? {});
    agency.state = StateModel.fromJson(json['state'] ?? {});
    agency.city = CityModel.fromJson(json['city'] ?? {});
    agency.packages = ((json['packages'] ?? []) as Iterable).map((package) => PackageModel.fromJson(package)).toList();

    return agency;
  }

  Map<String, String> toJson() {
    return {
      'id': this.id.toString(),
      'name': this.name,
      'brand_id': this.brandId.toString(),
      'city_id': this.cityId.toString(),
      'state_id': this.stateId.toString(),
      'color': this.color,
      'api_url': this.apiUrl
    };
  }
}