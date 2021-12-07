import 'package:uService/models/city_model.dart';

class StateModel {
  int id;
  String key;
  String name;
  String abrev;
  List<CityModel> cities;

  StateModel() {
    this.id = 0;
    this.key = '';
    this.name = '';
    this.abrev = '';
    this.cities = [];
  }

  factory StateModel.fromJson(Map<String, dynamic> json) {
    StateModel state = new StateModel();

    state.id = int.parse((json['id'] ?? 0).toString());
    state.key = json['clave'] ?? '';
    state.name = json['nombre'] ?? '';
    state.abrev = json['abrev'] ?? '';
    state.cities = ((json['municipalities'] ?? []) as Iterable).map((city) => CityModel.fromJson(city)).toList();

    return state;
  }
}