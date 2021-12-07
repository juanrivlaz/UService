import 'package:uuid/uuid.dart';

class ProductModel {
  String uuid; 
  int id;
  String name;
  String nameAgency;
  String codeAgency;
  int agencyId;
  String pathPresentation;
  double price;
  String linkPathPresentation;

  ProductModel() {
    this.uuid = Uuid().v1();
    this.id = 0;
    this.name = '';
    this.nameAgency = '';
    this.codeAgency = '';
    this.agencyId = 0;
    this.pathPresentation = '';
    this.price = 0;
    this.linkPathPresentation = '';
  }

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    ProductModel product = new ProductModel();

    product.id = int.parse((json['id'] ?? 0).toString());
    product.name = json['name_moc'] ?? '';
    product.nameAgency = json['name_agency'] ?? '';
    product.codeAgency = json['code_agency'] ?? '';
    product.agencyId = int.parse((json['agency_id'] ?? 0).toString());
    product.pathPresentation = json['path_presentation'] ?? '';
    product.price = double.parse((json['price'] ?? 0).toString());
    product.linkPathPresentation = json['link_path_presentation'] ?? '';

    return product;
  }

  Map<String, String> toJson() => {
    'id': this.id.toString(),
    'name_moc': this.name,
    'name_agency': this.nameAgency,
    'code_agency': this.codeAgency,
    'agency_id': this.agencyId.toString(),
    'price': this.price.toString()
  };
}