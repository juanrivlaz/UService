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

    if (json['model'] != null) {
      vehicle.brandId = int.parse((json['model']['id_marca'] ?? 0).toString());
      vehicle.model = json['model']['description'] ?? '';

      if (json['model']['marca'] != null) {
        vehicle.brandName = json['model']['marca']['description'] ?? '';
      }
    }
    
    vehicle.kilometraje = int.parse((json['kilometraje'] ?? 0).toString());
    
    vehicle.motor = json['motor'] ?? '';
    vehicle.year = int.parse((json['year'] ?? 0).toString());
    vehicle.color = json['color'] ?? '';
    vehicle.client = ClientModel.fromJson(json['client'] ?? {});

    return vehicle;
  }
}