class BrandModel {
  int id;
  String name;
  String code;

  BrandModel() {
    this.id = 0;
    this.name = '';
    this.code = '';
  }

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    BrandModel model = new BrandModel();

    model.id = int.parse((json['id'] ?? 0).toString());
    model.name = json['name'] ?? '';
    model.code = json['code'] ?? '';

    return model;
  }
}