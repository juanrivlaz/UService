class CityModel {
  int id;
  int stateId;
  String key;
  String name;

  CityModel() {
    this.id = 0;
    this.stateId = 0;
    this.key = '';
    this.name = '';
  }

  factory CityModel.fromJson(Map<String, dynamic> json) {
    CityModel city = new CityModel();

    city.id = int.parse((json['id'] ?? 0).toString());
    city.stateId = int.parse((json['estado_id'] ?? 0).toString());
    city.key = json['clave'] ?? '';
    city.name = json['nombre'] ?? '';

    return city;
  }
}