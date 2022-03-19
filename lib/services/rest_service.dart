import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:uService/models/DMS/client_model.dart';
import 'package:uService/models/DMS/marca_model.dart';
import 'package:uService/models/DMS/vehicle_model.dart';
import 'package:uService/models/agency_model.dart';
import 'package:uService/models/auth_response.dart';
import 'package:uService/models/brand_model.dart';
import 'package:uService/models/car_section_model.dart';
import 'package:uService/models/package_model.dart';
import 'package:uService/models/product_model.dart';
import 'package:uService/models/setting_package_model.dart';
import 'package:uService/models/state_model.dart';
import 'package:uService/models/type_service_model.dart';
import 'package:uService/services/setup_service.dart';
import 'package:uService/utils/app_settings.dart';
import 'package:uService/utils/preference_user.dart';
import 'package:http/http.dart' as http;

class RestService {
  String apiurl;
  PreferencesUser pref;
  bool envprod = false;

  RestService() {
    this.apiurl = appService<AppSettings>().apiUrl;
    this.pref = new PreferencesUser();
    this.envprod = appService<AppSettings>().envprod;
  }

  Future<AuthResponse> login({ @required String username, @required String password }) async {
    var url = new Uri.https(this.apiurl, 'auth/login');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'auth/login');
    }

    var response = await http.post(url, body: {
      'username': username,
      'password': password
    });

    var objresponse = json.decode(response.body);

    if (response.statusCode != 200) {
      throw( objresponse['message'] ?? 'Error inesperado, favor de intentar más tarde.');
    }

    AuthResponse auth = AuthResponse.fromJson(objresponse);
    this.pref.token = auth.token;
    this.pref.name = auth.user.name;
    this.pref.lastName = auth.user.lastName;
    this.pref.dmsCode = auth.user.dmsCode;
    this.pref.agencyId = auth.user.agencyId;

    return auth;
  }

  Future<AgencyModel> createAgency(AgencyModel agencyModel) async {
    var url = new Uri.https(this.apiurl, 'agencia');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'agencia');
    }

    final request = http.MultipartRequest('POST', url);
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${this.pref.token}';
    request.fields.addAll(agencyModel.toJson());
    request.files.add(http.MultipartFile(
        'logo',
        agencyModel.logo.readAsBytes().asStream(),
        agencyModel.logo.lengthSync(),
        filename: agencyModel.logo.path.split('/').last));

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Map<String, dynamic> responseBody = jsonDecode(await response.stream.bytesToString());

    return AgencyModel.fromJson(responseBody);
  }

  Future<AgencyModel> updateAgency(AgencyModel agencyModel) async {
    var url = new Uri.https(this.apiurl, 'agencia/${agencyModel.id}');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'agencia/${agencyModel.id}');
    }

    final request = http.MultipartRequest('POST', url);
    request.headers[HttpHeaders.authorizationHeader] = 'Bearer ${this.pref.token}';
    request.headers['Content-Type'] = 'application/json';
    request.fields.addAll(agencyModel.toJson());

    if (agencyModel.logo.path != '') {
      request.files.add(http.MultipartFile(
        'logo',
        agencyModel.logo.readAsBytes().asStream(),
        agencyModel.logo.lengthSync(),
        filename: agencyModel.logo.path.split('/').last));
    }

    http.StreamedResponse response = await request.send();

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Map<String, dynamic> responseBody = jsonDecode(await response.stream.bytesToString());

    return AgencyModel.fromJson(responseBody);

  }

  Future<List<StateModel>> getStates() async {
    var url = new Uri.https(this.apiurl, 'state');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'state');
    }

    var response = await http.get(url, headers: this.getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Iterable iterable = jsonDecode(response.body);

    List<StateModel> states = iterable.map((value) => StateModel.fromJson(value)).toList();

    return states;
  }

  Future<List<BrandModel>> getBrands() async {
    var url = new Uri.https(this.apiurl, 'brand');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'brand');
    }

    var response = await http.get(url, headers: this.getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Iterable iterable = jsonDecode(response.body);

    List<BrandModel> brands = iterable.map((value) => BrandModel.fromJson(value)).toList();

    return brands;
  }

  Future<List<AgencyModel>> getAgencies() async {
    var url = new Uri.https(this.apiurl, 'agencia');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'agencia');
    }

    var response = await http.get(url, headers: getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Iterable iterable = jsonDecode(response.body);

    List<AgencyModel> brands = iterable.map((value) => AgencyModel.fromJson(value)).toList();

    return brands;
  }

  Future<List<TypeServiceModel>> getTypesService() async {
    Iterable iterable = [
      {
        'id': 1,
        'label': 'Mantenimiento',
        'dms_code': 'mantenimiento',
        'agency_id': 1
      },
      {
        'id': 2,
        'label': 'Garantia',
        'dms_code': 'garantia',
        'agency_id': 1
      },
      {
        'id': 3,
        'label': 'Reparacion',
        'dms_code': 'reparacion',
        'agency_id': 1
      }
    ];

    List<TypeServiceModel> typesService = iterable.map((value) => TypeServiceModel.fromJson(value)).toList();

    return typesService;
  }

  Future<List<ProductModel>> getProductsByAgency(int agencyId) async {
    Iterable iterable = [{
      'id': 1,
      'name_moc': 'Camara de combustion',
      'name_agency': 'Lavado de injector',
      'code_agency': 'M00009',
      'agency_id': 1,
      'path_presentation': 'product/yuE1FwpLFw6vaXsfRocF5u1ru3Rxi8IJaNHw79ZK.jpg',
      'price': '129.6',
      'link_path_presentation': 'https://img.autocosmos.com/noticias/fotosprinc/0_17153030630.jpg'
    },
    {
      'id': 2,
      'name_moc': 'Kit de Motor',
      'name_agency': 'Kit de Motor',
      'code_agency': 'M00010',
      'agency_id': 1,
      'path_presentation': 'product/yuE1FwpLFw6vaXsfRocF5u1ru3Rxi8IJaNHw79ZK.jpg',
      'price': '290',
      'link_path_presentation': 'https://img.autocosmos.com/noticias/fotosprinc/0_17153030630.jpg'
    },
    {
      'id': 3,
      'name_moc': 'CAMBIO DE ACEITE Y FILTRO DE MOTOR',
      'name_agency': 'CAMBIO DE ACEITE Y FILTRO DE MOTOR',
      'code_agency': 'M00012',
      'agency_id': 1,
      'path_presentation': 'product/yuE1FwpLFw6vaXsfRocF5u1ru3Rxi8IJaNHw79ZK.jpg',
      'price': '120',
      'link_path_presentation': 'https://img.autocosmos.com/noticias/fotosprinc/0_17153030630.jpg'
    },
    {
      'id': 4,
      'name_moc': 'ROTACION DE RUEDAS',
      'name_agency': 'ROTACION DE RUEDAS',
      'code_agency': 'M00014',
      'agency_id': 1,
      'path_presentation': 'product/yuE1FwpLFw6vaXsfRocF5u1ru3Rxi8IJaNHw79ZK.jpg',
      'price': '90',
      'link_path_presentation': 'https://img.autocosmos.com/noticias/fotosprinc/0_17153030630.jpg'
    }];

    List<ProductModel> products = iterable.map((value) => ProductModel.fromJson(value)).toList();

    return products;
  }

  Future<bool> saveAgencyPackages(List<PackageModel> packages, int agencyId) async {
    var url = new Uri.https(this.apiurl, 'agencia/$agencyId/update-package');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'agencia/$agencyId/update-package');
    }

    var body = {
      'packages': packages.map((package) => package.toJson()).toList()
    };

    var response = await http.put(url, body: jsonEncode(body), headers: this.getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    return true;
  }

  Future<List<CarSectionModel>> getCarSections() async {
    Iterable iterable = [
      {
        'id': 1,
        'label': 'Defensa'
      },
      {
        'id': 2,
        'label': 'Parabrisas'
      },
      {
        'id': 3,
        'label': 'Puertas'
      },
      {
        'id': 4,
        'label': 'Faros'
      },
      {
        'id': 5,
        'label': 'Calaberas'
      },
      {
        'id': 6,
        'label': 'Interior'
      },
      {
        'id': 7,
        'label': 'Limpieza'
      }
    ];

    List<CarSectionModel> sections = iterable.map((value) => CarSectionModel.fromJson(value)).toList();

    return sections;
  } 

  Future<List<SettingPackageModel>> getSettingPackageByKM(int km) async {

    Iterable iterable = [
      {
        'id': 1,
        'initial_year': 0,
        'final_year': 2019,
        'km_initial': 5000,
        'every_km': 10000,
        'package': {
          'id': 1,
          'name': 'Paquete 1',
          'color': '#B6B6B6',
          'price': 1400
        },
        'products': [
          {
            'id': 1,
            'name_moc': 'Filtro de aceite',
            'name_agency': 'Filtro de aceite',
            'code_agency': 'filtro',
            'agency_id': 1,
            'price': 120
          },
          {
            'id': 1,
            'name_moc': 'Aceite de motor',
            'name_agency': 'Aceite de motor',
            'code_agency': 'Aceite',
            'agency_id': 1,
            'price': 180
          },
          {
            'id': 1,
            'name_moc': 'Arandela',
            'name_agency': 'Arandela',
            'code_agency': 'Arandela',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Shampoo limpiaparabrisas',
            'name_agency': 'Shampoo limpiaparabrisas',
            'code_agency': 'shanpoo',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Revision de puntos de seguridad',
            'name_agency': 'Revision de puntos de seguridad',
            'code_agency': 'revision_seguridad',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de motor',
            'name_agency': 'Lavado de motor',
            'code_agency': 'lavado motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de carroceria',
            'name_agency': 'Lavado de carroceria',
            'code_agency': 'lavado carroceria',
            'agency_id': 1,
            'price': 100
          }
        ]
      },
      {
        'id': 1,
        'initial_year': 0,
        'final_year': 2019,
        'km_initial': 5000,
        'every_km': 10000,
        'package': {
          'id': 1,
          'name': 'Paquete 2',
          'color': '#3961FF',
          'price': 1400
        },
        'products': [
          {
            'id': 1,
            'name_moc': 'Filtro de aceite',
            'name_agency': 'Filtro de aceite',
            'code_agency': 'filtro',
            'agency_id': 1,
            'price': 120
          },
          {
            'id': 1,
            'name_moc': 'Aceite de motor',
            'name_agency': 'Aceite de motor',
            'code_agency': 'Aceite',
            'agency_id': 1,
            'price': 180
          },
          {
            'id': 1,
            'name_moc': 'Arandela',
            'name_agency': 'Arandela',
            'code_agency': 'Arandela',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Shampoo limpiaparabrisas',
            'name_agency': 'Shampoo limpiaparabrisas',
            'code_agency': 'shanpoo',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Revision de puntos de seguridad',
            'name_agency': 'Revision de puntos de seguridad',
            'code_agency': 'revision_seguridad',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de motor',
            'name_agency': 'Lavado de motor',
            'code_agency': 'lavado motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de carroceria',
            'name_agency': 'Lavado de carroceria',
            'code_agency': 'lavado carroceria',
            'agency_id': 1,
            'price': 100
          }
        ]
      },
      {
        'id': 1,
        'initial_year': 0,
        'final_year': 2019,
        'km_initial': 5000,
        'every_km': 10000,
        'package': {
          'id': 1,
          'name': 'Paquete 3',
          'color': '#00D003',
          'price': 1400
        },
        'products': [
          {
            'id': 1,
            'name_moc': 'Filtro de aceite',
            'name_agency': 'Filtro de aceite',
            'code_agency': 'filtro',
            'agency_id': 1,
            'price': 120
          },
          {
            'id': 1,
            'name_moc': 'Aceite de motor',
            'name_agency': 'Aceite de motor',
            'code_agency': 'Aceite',
            'agency_id': 1,
            'price': 180
          },
          {
            'id': 1,
            'name_moc': 'Arandela',
            'name_agency': 'Arandela',
            'code_agency': 'Arandela',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Shampoo limpiaparabrisas',
            'name_agency': 'Shampoo limpiaparabrisas',
            'code_agency': 'shanpoo',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Revision de puntos de seguridad',
            'name_agency': 'Revision de puntos de seguridad',
            'code_agency': 'revision_seguridad',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de motor',
            'name_agency': 'Lavado de motor',
            'code_agency': 'lavado motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de carroceria',
            'name_agency': 'Lavado de carroceria',
            'code_agency': 'lavado carroceria',
            'agency_id': 1,
            'price': 100
          }
        ]
      }
    ];

    List<SettingPackageModel> settings = iterable.map((value) => SettingPackageModel.fromJson(value)).toList();

    return settings;
  }

  Future<List<VehicleModel>> getVehicles({ String filter = '' }) async {
    Iterable iterable = [];

    List<VehicleModel> vehicles = iterable.map((value) => VehicleModel.fromJson(value)).toList();

    return vehicles;
  }

  Future<List<MarcaModel>> getMarcas() async {
    Iterable iterable = [{
      'id': 1,
      'description': 'NISSAN',
      'predet': 1,
      'order': 1,
      'models': [
        {
          'id': 1,
          'description': 'Tida',
          'id_marca': 1,
          'inactivo': 0
        }
      ]
    }];

    List<MarcaModel> marcas = iterable.map((item) => MarcaModel.fromJson(item)).toList();


    return marcas;
  }

  Future<List<ClientModel>> getClients() async {
    Iterable iterable = [
      {
        'id': -1,
        'rfc': 'RILJ9308051S8',
        'address': 'Paseo de los olivos 918',
        'colony': 'Altagracia',
        'city': 'Zapopan',
        'state': 'Jalisco',
        'postcode': '45130',
        'name': 'Juan Daniel Rivera Lazaro'
      }
    ];

    List<ClientModel> clients = iterable.map((item) => ClientModel.fromJson(item)).toList();
    await Future.delayed(Duration(seconds: 2));

    return clients;
  }

  Map<String, String> getHeader() {
    return {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${this.pref.token}'
    };
  }
}
