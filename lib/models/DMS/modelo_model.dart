class ModeloModel {
  int id;
  String description;
  int idMarca;
  int inactivo;

  ModeloModel({
    this.id = 0,
    this.description = '',
    this.idMarca = 0,
    this.inactivo = 0
  });

  factory ModeloModel.fromJson(Map<String, dynamic> json) {
    return ModeloModel(
      id: int.parse('${json['id'] ?? 0}'),
      description: json['description'] ?? '',
      idMarca: int.parse('${json['id_marca'] ?? 0}'),
      inactivo: int.parse('${json['inactivo'] ?? 0}')
    );
  }

  Map<String, String> toJson() {
    return {
      'id': id.toString(),
      'description': description,
      'id_marca': idMarca.toString(),
      'inactivo': inactivo.toString()
    };
  }
}