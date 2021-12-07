class TypeServiceModel {
  int id;
  String label;
  String dmsCode;
  int agencyId;

  TypeServiceModel() {
    this.id = 0;
    this.label = '';
    this.dmsCode = '';
    this.agencyId = 0;
  }

  factory TypeServiceModel.fromJson(Map<String, dynamic> json) {
    TypeServiceModel typeService = new TypeServiceModel();

    typeService.id = int.parse((json['id'] ?? 0).toString());
    typeService.label = json['label'] ?? '';
    typeService.dmsCode = json['dms_code'] ?? '';
    typeService.agencyId = int.parse((json['agency_id'] ?? 0).toString());

    return typeService;
  }
}