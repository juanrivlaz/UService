import 'package:uService/models/DMS/contact_model.dart';

class ClientModel {
  int id;
  String rfc;
  String address;
  String colony;
  String city;
  String state;
  String postcode;
  String name;
  ContactModel contact;

  ClientModel() {
    this.id = 0;
    this.rfc = '';
    this.address = '';
    this.colony = '';
    this.city = '';
    this.state = '';
    this.postcode = '';
    this.name = '';
    this.contact = ContactModel.fromJson({});
  }

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    ClientModel client = new ClientModel();

    client.id = int.parse('${json['id'] ?? 0}');
    client.rfc = json['rfc'] ?? '';
    client.address = json['address'] ?? '';
    client.colony = json['colony'] ?? '';
    client.city = json['city'] ?? '';
    client.state = json['state'] ?? '';
    client.postcode = json['postcode'] ?? '';
    client.name = json['name'] ?? '';
    client.contact = ContactModel.fromJson(json['contact'] ?? {});

    return client;
  }
}