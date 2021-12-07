import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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
    var url = new Uri.https(this.apiurl, 'type-service');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'type-service');
    }

    var response = await http.get(url, headers: this.getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Iterable iterable = jsonDecode(response.body);

    List<TypeServiceModel> typesService = iterable.map((value) => TypeServiceModel.fromJson(value)).toList();

    return typesService;
  }

  Future<List<ProductModel>> getProductsByAgency(int agencyId) async {
    var url = new Uri.https(this.apiurl, 'agencia/$agencyId/products');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'agencia/$agencyId/products');
    }

    var response = await http.get(url, headers: this.getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Iterable iterable = jsonDecode(response.body);

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
    var url = new Uri.https(this.apiurl, 'car-section-review');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'car-section-review');
    }

    var response = await http.get(url, headers: this.getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Iterable iterable = jsonDecode(response.body);

    List<CarSectionModel> sections = iterable.map((value) => CarSectionModel.fromJson(value)).toList();

    return sections;
  } 

  Future<List<SettingPackageModel>> getSettingPackageByKM(int km) async {
    var url = new Uri.https(this.apiurl, 'service-order/package-for-order');

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'service-order/package-for-order');
    }

    var body = {
      'km': km
    };

    var response = await http.post(url, body: jsonEncode(body), headers: this.getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Iterable iterable = jsonDecode(response.body);

    List<SettingPackageModel> settings = iterable.map((value) => SettingPackageModel.fromJson(value)).toList();

    return settings;
  }

  Future<List<VehicleModel>> getVehicles({ String filter = '' }) async {
    var url = new Uri.https(this.apiurl, 'dms/vehicles', { 'filter' : filter });

    if (!this.envprod) {
      url = new Uri.http(this.apiurl, 'dms/vehicles', { 'filter' : filter });
    }

    var response = await http.get(url, headers: this.getHeader());

    if (response.statusCode != 200) {
      throw('Error inesperado, favor de intentar más tarde.');
    }

    Iterable iterable = jsonDecode(response.body);

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
