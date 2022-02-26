import 'package:uService/models/DMS/modelo_model.dart';

class MarcaModel {
  int id;
  String description;
  int predet;
  int order;
  List<ModeloModel> models = [];

  MarcaModel({
    this.id,
    this.description = '',
    this.predet = 0,
    this.order = 1,
    this.models
  });

  factory MarcaModel.fromJson(Map<String, dynamic> json) {
    Iterable models = json['models'] ?? [];

    return MarcaModel(
      id: int.parse('${json['id'] ?? 0}'),
      description: json['description'],
      predet: int.parse('${json['predet'] ?? 0}'),
      order: int.parse('${json['order'] ?? 0}'),
      models: models.map((item) => ModeloModel.fromJson(item)).toList()
    );
  }
}