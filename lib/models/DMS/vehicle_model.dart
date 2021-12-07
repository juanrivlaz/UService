import 'package:uService/models/DMS/client_model.dart';

class VehicleModel {
  String serie;
  String placas;
  int brandId;
  String brandName;
  int kilometraje;
  String model;
  String motor;
  int year;
  String color;
  ClientModel client;

  VehicleModel() {
    this.serie = '';
    this.placas = '';
    this.brandId = 0;
    this.brandName = '';
    this.kilometraje = 0;
    this.model = '';
    this.motor = '';
    this.year = 0;
    this.color = '';
    this.client = ClientModel.fromJson({});
  }

  factory VehicleModel.fromJson(Map<String, dynamic> json) {
    VehicleModel vehicle = new VehicleModel();

    vehicle.serie = json['serie'] ?? '';
    vehicle.placas = json['placas'] ?? '';
    vehicle.brandId = int.parse((json['brand_id'] ?? 0).toString());
    vehicle.brandName = json['brand_name'] ?? '';
    vehicle.kilometraje = int.parse((json['kilometraje'] ?? 0).toString());
    vehicle.model = json['model'] ?? '';
    vehicle.motor = json['motor'] ?? '';
    vehicle.year = int.parse((json['year'] ?? 0).toString());
    vehicle.color = json['color'] ?? '';
    vehicle.client = ClientModel.fromJson(json['client'] ?? {});

    return vehicle;
  }
}