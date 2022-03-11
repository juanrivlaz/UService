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
    AuthResponse auth = AuthResponse.fromJson({
      'access_token': '',
      'user': {
        'id': 1,
        'name': 'juan',
        'last_name': 'rivera',
        'dms_code': 'nissan',
        'agency_id': 1,
        'rol_id': 1
      }
    });
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

    Iterable iterable = [
      {
        'id': 1,
        'clave': 'JL',
        'nombre': 'JALISCO',
        'abrev': 'JAL',
        'municipalities': [
          {
            'id': 1,
            'estado_id': 1,
            'clave': 'zap',
            'nombre': 'Zapopan'
          }
        ]
      },
      {
        'id': 2,
        'clave': 'NY',
        'nombre': 'NAYARIT',
        'abrev': 'NAY',
        'municipalities': [
          {
            'id': 1,
            'estado_id': 2,
            'clave': 'com',
            'nombre': 'Compostela'
          }
        ]
      }
    ];

    List<StateModel> states = iterable.map((value) => StateModel.fromJson(value)).toList();

    return states;
  }

  Future<List<BrandModel>> getBrands() async {
    Iterable iterable = [
      {
        'id': 1,
        'name': 'NISSAN',
        'code': 'nissan'
      }
    ];

    List<BrandModel> brands = iterable.map((value) => BrandModel.fromJson(value)).toList();

    return brands;
  }

  Future<List<AgencyModel>> getAgencies() async {
    Iterable iterable = [
      {
        'id': 1,
        'name': 'NISSAN',
        'brand_id': 1,
        'city_id': 1,
        'state_id': 1,
        'color': '#868686',
        'api_url': 'http://localhost/',
        'brand': {
          'id': 1,
          'name': 'NISSAN',
          'code': 'nissan'
        },
        'state': {
          'id': 1,
          'clave': 'JL',
          'nombre': 'JALISCO',
          'abrev': 'JAL'
        },
        'city': {
          'id': 1,
          'estado_id': 1,
          'clave': 'zp',
          'nombre': 'ZAPOPAN'
        },
      }
    ];

    List<AgencyModel> brands = iterable.map((value) => AgencyModel.fromJson(value)).toList();

    return brands;
  }

  Future<List<TypeServiceModel>> getTypesService() async {

    Iterable iterable = [
      {
        'id': 1,
        'label': 'Mantenimiento',
        'dms_code': 'service'
      },
      {
        'id': 2,
        'label': 'Garantia',
        'dms_code': 'garantia'
      }
    ];

    List<TypeServiceModel> typesService = iterable.map((value) => TypeServiceModel.fromJson(value)).toList();

    return typesService;
  }

  Future<List<MarcaModel>> getMarcas() async {

    Iterable iterable = [
      {
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
          },
          {
            'id': 2,
            'description': 'Tida Std*',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 3,
            'description': 'NP300 (D22)*',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 4,
            'description': 'March',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 5,
            'description': 'March Std*',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 6,
            'description': 'V-drive',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 7,
            'description': 'Versa Std*',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 8,
            'description': 'Sentra 2013 CVT',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 9,
            'description': 'Sentra 2013 Std*',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 10,
            'description': 'Note',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 11,
            'description': 'Versa 2020 CVT',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 12,
            'description': 'Versa 2020 Std*',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 13,
            'description': 'Sentra 2020 CVT',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 14,
            'description': 'Sentra 2020 Std*',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 15,
            'description': 'Pathfinder 2013 FWD',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 16,
            'description': 'Pathfinder 2013 AWD',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 17,
            'description': 'Altima L33',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 18,
            'description': 'Altima L34',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 19,
            'description': 'NP300 Frontier 2016*+',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 20,
            'description': 'Xtrail 2015',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 21,
            'description': 'Maxima 2016',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 22,
            'description': 'Kicks CVT',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 23,
            'description': 'Kicks Std*',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 24,
            'description': 'Frontier Pro4x*+',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 25,
            'description': 'Murano',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 26,
            'description': '370 Z',
            'id_marca': 1,
            'inactivo': 0
          },
          {
            'id': 27,
            'description': 'Juke',
            'id_marca': 1,
            'inactivo': 0
          }
        ]
      }
    ];

    List<MarcaModel> marcas = iterable.map((item) => MarcaModel.fromJson(item)).toList();

    await Future.delayed(Duration(seconds: 2));

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

  Future<List<ProductModel>> getProductsByAgency(int agencyId) async {

    Iterable iterable = [
      {
        'id': 1,
        'name_moc': 'LIMPIEZA A LA CAMARA DE COMBUSTION',
        'name_agency': 'LIMPIEZA A LA CAMARA DE COMBUSTION',
        'code_agency': 'LIM',
        'agency_id': 1,
        'path_presentation': 'https://www.carroya.com/noticias/sites/default/files/entradillas/482620708carroyainflarlasllantasdelcarro.png',
        'price': 699,
        'link_path_presentation': 'https://www.carroya.com/noticias/sites/default/files/entradillas/482620708carroyainflarlasllantasdelcarro.png'
      },
      {
        'id': 2,
        'name_moc': 'ALINEACION, BALANCEO, NITROGENO, ROTACION',
        'name_agency': 'ALINEACION, BALANCEO, NITROGENO, ROTACION',
        'code_agency': 'L41',
        'agency_id': 1,
        'path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg',
        'price': 699,
        'link_path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg'
      },
      {
        'id': 3,
        'name_moc': 'SERVICIO CVT',
        'name_agency': 'SERVICIO CVT',
        'code_agency': 'H71',
        'agency_id': 1,
        'path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg',
        'price': 3900,
        'link_path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg'
      },
      {
        'id': 4,
        'name_moc': 'SERVICIO TRANSMISION AUTOMATICA',
        'name_agency': 'SERVICIO TRANSMISION AUTOMATICA',
        'code_agency': 'H16',
        'agency_id': 1,
        'path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg',
        'price': 4100,
        'link_path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg'
      },
      {
        'id': 5,
        'name_moc': 'SERVICIO A/AC',
        'name_agency': 'SERVICIO A/AC',
        'code_agency': 'E39',
        'agency_id': 1,
        'path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg',
        'price': 1700,
        'link_path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg'
      },
      {
        'id': 6,
        'name_moc': 'ACONDICIONADOR DE MOTOR',
        'name_agency': 'ACONDICIONADOR DE MOTOR',
        'code_agency': 'Z02',
        'agency_id': 1,
        'path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg',
        'price': 470,
        'link_path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg'
      },
      {
        'id': 7,
        'name_moc': 'LIMPIEZA Y LUBRICACION SIST ENFRIAMIENTO',
        'name_agency': 'LIMPIEZA Y LUBRICACION SIST ENFRIAMIENTO',
        'code_agency': 'Z04',
        'agency_id': 1,
        'path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg',
        'price': 170,
        'link_path_presentation': 'https://dupesan.es/wp-content/uploads/2017/01/mantenimiento-caja-cambios-automatica2.jpg'
      }
    ];

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
        'label': 'Puerta'
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
      },
    ];

    List<CarSectionModel> sections = iterable.map((value) => CarSectionModel.fromJson(value)).toList();

    return sections;
  } 

  Future<List<SettingPackageModel>> getSettingPackageByKM(int km, int idVehicle) async {
    Map<String, dynamic> settingsD = {
      'id': 1,
      'initial_year': 0,
      'final_year': 2019,
      'km_initial': 5000,
      'every_km': 10000,
      'package': {
        'id': 1,
        'name': 'Paquete 1',
        'color': '#63666B',
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
    };

    if (km == 5000) {
      //price 1300
      if ([3, 10].contains(idVehicle)) {
        settingsD['package']['price'] = 1300;
      }

      if ([13, 14].contains(idVehicle)) {
        settingsD['package']['price'] = 1650;
      }

      if ([15, 16, 19, 20, 22, 23, 24, 27].contains(idVehicle)) {
        settingsD['package']['price'] = 1550;
      }

      if ([18, 21].contains(idVehicle)) {
        settingsD['package']['price'] = 1600;
      }

      if (idVehicle == 25) {
        settingsD['package']['price'] = 1450;
      }
    } else if ([10000, 30000, 50000].contains(km)) {
      settingsD = {
        'id': 1,
        'initial_year': 0,
        'final_year': 2019,
        'km_initial': 5000,
        'every_km': 10000,
        'package': {
          'id': 1,
          'name': 'Paquete 1',
          'color': '#63666B',
          'price': 4400
        },
        'products': [
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
            'name_moc': 'Filtro de aceite',
            'name_agency': 'Filtro de aceite',
            'code_agency': 'filtroaceite',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Arandela',
            'name_agency': 'Arandela',
            'code_agency': 'arandela',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Filtro de aire de motor',
            'name_agency': 'Filtro de aire de motor',
            'code_agency': 'aire motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Protector para terminales',
            'name_agency': 'Protector para terminales',
            'code_agency': 'protector terminal',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Desinfectante nanobiocida',
            'name_agency': 'Desinfectante nanobiocida',
            'code_agency': 'desinfectante',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Protector de vinil',
            'name_agency': 'Protector de vinil',
            'code_agency': 'protector vinil',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Alineación y balanceo',
            'name_agency': 'Alineación y balanceo',
            'code_agency': 'alineacion y balanceo',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Limpieza de inyectores',
            'name_agency': 'Limpieza de inyectores',
            'code_agency': 'limpieza inyectores',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Limpieza de camara de combustion',
            'name_agency': 'Limpieza de camara de combustion',
            'code_agency': 'limpieza camara combustion',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de motor',
            'name_agency': 'Lavado de motor',
            'code_agency': 'Lavado de motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de carroceria',
            'name_agency': 'Lavado de carroceria',
            'code_agency': 'Lavado de carroceria',
            'agency_id': 1,
            'price': 100
          }
        ]
      };

      if ([1, 2].contains(idVehicle)) {
        settingsD['package']['price'] = 4350;
      }

      if ([3, 8, 9].contains(idVehicle)) {
        settingsD['package']['price'] = 4250;
      }

      if ([11, 12, 13, 14, 22, 23].contains(idVehicle)) {
        settingsD['package']['price'] = 4600;
      }

      if ([15, 16, 19, 21, 25].contains(idVehicle)) {
        settingsD['package']['price'] = 4300;
      }

      if ([17, 26].contains(idVehicle)) {
        settingsD['package']['price'] = 4800;
      }

      if (idVehicle == 18) {
        settingsD['package']['price'] = 5150;
      }

      if (idVehicle == 20) {
        settingsD['package']['price'] = 4700;
      }

      if (idVehicle == 24) {
        settingsD['package']['price'] = 4500;
      }

      if (idVehicle == 27) {
        settingsD['package']['price'] = 4450;
      }

    } else if ([20000, 60000].contains(km) || km > 60000) {
      settingsD = {
        'id': 1,
        'initial_year': 0,
        'final_year': 2019,
        'km_initial': 5000,
        'every_km': 10000,
        'package': {
          'id': 1,
          'name': 'Paquete 1',
          'color': '#63666B',
          'price': 4950
        },
        'products': [
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
            'name_moc': 'Filtro de aceite',
            'name_agency': 'Filtro de aceite',
            'code_agency': 'filtroaceite',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Arandela',
            'name_agency': 'Arandela',
            'code_agency': 'arandela',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Filtro de A/C',
            'name_agency': 'Filtro de A/C',
            'code_agency': 'filtro ac',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Filtro de aire de motor',
            'name_agency': 'Filtro de aire de motor',
            'code_agency': 'aire motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Protector para terminales',
            'name_agency': 'Protector para terminales',
            'code_agency': 'protector terminal',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Desinfectante nanobiocida',
            'name_agency': 'Desinfectante nanobiocida',
            'code_agency': 'desinfectante',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Protector de vinil',
            'name_agency': 'Protector de vinil',
            'code_agency': 'protector vinil',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Limpieza cuerpo de aceleración',
            'name_agency': 'Limpieza cuerpo de aceleración',
            'code_agency': 'cuerpo aceleracion',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Limpieza camara de combustion',
            'name_agency': 'Limpieza camara de combustion',
            'code_agency': 'camara combustion',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Limpieza de frenos',
            'name_agency': 'Limpieza de frenos',
            'code_agency': 'limp frenos',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Ajuste de suspension',
            'name_agency': 'Ajuste de suspension',
            'code_agency': 'Ajuste de suspension',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de motor',
            'name_agency': 'Lavado de motor',
            'code_agency': 'Lavado de motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de carroceria',
            'name_agency': 'Lavado de carroceria',
            'code_agency': 'Lavado de carroceria',
            'agency_id': 1,
            'price': 100
          }
        ]
      };

      if ([1, 2, 15, 16, 24].contains(idVehicle)) {
        settingsD['package']['price'] = 5050;
      }

      if (idVehicle == 3) {
        settingsD['package']['price'] = 4600;
      }

      if ([1, 2, 15, 16, 24].contains(idVehicle)) {
        settingsD['package']['price'] = 5050;
      }

      if ([8, 9].contains(idVehicle)) {
        settingsD['package']['price'] = 4700;
      }

      if ([11, 12, 13, 14].contains(idVehicle)) {
        settingsD['package']['price'] = 5300;
      }

      if ([17, 27].contains(idVehicle)) {
        settingsD['package']['price'] = 5600;
      }

      if (idVehicle == 18) {
        settingsD['package']['price'] = 6100;
      }

      if (idVehicle == 20) {
        settingsD['package']['price'] = 5650;
      }

      if ([22, 23].contains(idVehicle)) {
        settingsD['package']['price'] = 5350;
      }

      if (idVehicle == 25) {
        settingsD['package']['price'] = 5200;
      }

      if (idVehicle == 26) {
        settingsD['package']['price'] = 5900;
      }

    } else if (km == 40000) {
      settingsD = {
        'id': 1,
        'initial_year': 0,
        'final_year': 2019,
        'km_initial': 5000,
        'every_km': 10000,
        'package': {
          'id': 1,
          'name': 'Paquete 1',
          'color': '#63666B',
          'price': 5950
        },
        'products': [
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
            'name_moc': 'Filtro de aceite',
            'name_agency': 'Filtro de aceite',
            'code_agency': 'filtroaceite',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Arandela',
            'name_agency': 'Arandela',
            'code_agency': 'arandela',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Filtro de A/C',
            'name_agency': 'Filtro de A/C',
            'code_agency': 'filtro ac',
            'agency_id': 1,
            'price': 10
          },
          {
            'id': 1,
            'name_moc': 'Filtro de aire de motor',
            'name_agency': 'Filtro de aire de motor',
            'code_agency': 'aire motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Protector para terminales',
            'name_agency': 'Protector para terminales',
            'code_agency': 'protector terminal',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Desinfectante nanobiocida',
            'name_agency': 'Desinfectante nanobiocida',
            'code_agency': 'desinfectante',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Protector de vinil',
            'name_agency': 'Protector de vinil',
            'code_agency': 'protector vinil',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Limpieza cuerpo de aceleración',
            'name_agency': 'Limpieza cuerpo de aceleración',
            'code_agency': 'cuerpo aceleracion',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Limpieza camara de combustion',
            'name_agency': 'Limpieza camara de combustion',
            'code_agency': 'camara combustion',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Limpieza de frenos',
            'name_agency': 'Limpieza de frenos',
            'code_agency': 'limp frenos',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Reemplazo de anticongelante',
            'name_agency': 'Reemplazo de anticongelante',
            'code_agency': 'anticongelante',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Liquido de frenos',
            'name_agency': 'Liquido de frenos',
            'code_agency': 'liquido frenos',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Ajuste de suspension',
            'name_agency': 'Ajuste de suspension',
            'code_agency': 'Ajuste de suspension',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de motor',
            'name_agency': 'Lavado de motor',
            'code_agency': 'Lavado de motor',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Lavado de carroceria',
            'name_agency': 'Lavado de carroceria',
            'code_agency': 'Lavado de carroceria',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Aceite de transmision',
            'name_agency': 'Aceite de transmision',
            'code_agency': 'aceite transmision',
            'agency_id': 1,
            'price': 100
          },
          {
            'id': 1,
            'name_moc': 'Aceite diferencial',
            'name_agency': 'Aceite diferencial',
            'code_agency': 'aceite diferencial',
            'agency_id': 1,
            'price': 100
          }
        ]
      };

      if (idVehicle == 2) {
        settingsD['package']['price'] = 6900;
      }

      if (idVehicle == 3) {
        settingsD['package']['price'] = 8200;
      } 

      if ([4, 6].contains(idVehicle)) {
        settingsD['package']['price'] = 5900;
      }

      if ([5, 7].contains(idVehicle)) {
        settingsD['package']['price'] = 7600;
      }

      if (idVehicle == 8) {
        settingsD['package']['price'] = 5700;
      }

      if (idVehicle == 9) {
        settingsD['package']['price'] = 7400;
      }

      if (idVehicle == 10) {
        settingsD['package']['price'] = 5850;
      }

      if ([11, 13, 22].contains(idVehicle)) {
        settingsD['package']['price'] = 6250;
      }

      if ([12, 14, 23].contains(idVehicle)) {
        settingsD['package']['price'] = 7950;
      }

      if ([17, 25].contains(idVehicle)) {
        settingsD['package']['price'] = 6100;
      }

      if (idVehicle == 18) {
        settingsD['package']['price'] = 7000;
      }

      if (idVehicle == 19) {
        settingsD['package']['price'] = 9200;
      }

      if (idVehicle == 20) {
        settingsD['package']['price'] = 6550;
      }

      if (idVehicle == 21) {
        settingsD['package']['price'] = 5800;
      }

      if (idVehicle == 24) {
        settingsD['package']['price'] = 7200;
      }

      if (idVehicle == 26) {
        settingsD['package']['price'] = 6800;
      }

      if (idVehicle == 27) {
        settingsD['package']['price'] = 6500;
      }
    }

    Iterable iterable = [settingsD];

    List<SettingPackageModel> settings = iterable.map((value) => SettingPackageModel.fromJson(value)).toList();

    return settings;
  }

  Future<List<VehicleModel>> getVehicles({ String filter = '' }) async {
    Iterable iterable = [];

    List<VehicleModel> vehicles = iterable.map((value) => VehicleModel.fromJson(value)).toList();

    return vehicles;
  }

  Map<String, String> getHeader() {
    return {
      'Content-Type': 'application/json',
      HttpHeaders.authorizationHeader: 'Bearer ${this.pref.token}'
    };
  }
}
