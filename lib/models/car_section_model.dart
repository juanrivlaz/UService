class CarSectionModel {
  int id;
  String label;
  int status;

  CarSectionModel() {
    this.id = 0;
    this.label = '';
    this.status = 0;
  }

  factory CarSectionModel.fromJson(Map<String, dynamic> json) {
    CarSectionModel carSection = new CarSectionModel();

    carSection.id = int.parse((json['id'] ?? 0).toString());
    carSection.label = json['label'] ?? '';

    return carSection;
  }
}