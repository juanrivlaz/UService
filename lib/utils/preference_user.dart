import 'package:shared_preferences/shared_preferences.dart';
import 'package:uService/utils/decode_jwt.dart';

class PreferencesUser {
  static final PreferencesUser _instance = new PreferencesUser._internal();

  factory PreferencesUser() {
    return _instance;
  }

  PreferencesUser._internal();
  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  get id {
    return _prefs.getInt('id') ?? 0;
  }

  set id(int value) {
    _prefs.setInt('id', value);
  }

  get name {
    return _prefs.getString('name');
  }

  set name(String value) {
    _prefs.setString('name', value);
  }

  get lastName {
    return _prefs.getString('last_name');
  }

  set lastName(String value) {
    _prefs.setString('last_name', value);
  }

  set dmsCode(String value) {
    _prefs.setString('dms_code', value);
  }

  get dmsCode {
    return _prefs.getString('dms_code');
  }

  set agencyId(int value) {
    _prefs.setInt('agency_id', value);
  }

  get agencyId {
    return _prefs.getInt('agency_id');
  }

  get email {
    return _prefs.getString('email') ?? '';
  }

  set email(String value) {
    _prefs.setString('email', value);
  }

  get cardNumber {
    return _prefs.getString('card_number') ?? '';
  }

  set cardNumber(String value) {
    _prefs.setString('card_number', value);
  }

  get logged {
    return validToken(this.token, true);
  }

  get token {
    return _prefs.getString('token') ?? '';
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get telephone {
    return _prefs.getString('telephone') ?? '';
  }

  set telephone(String value) {
    _prefs.setString('telephone', value);
  }

  get activeRoute {
    return _prefs.getString('active_route') ?? '';
  }

  set activeRoute(String value) {
    _prefs.setString('active_route', value);
  }

  get tokenDevice {
    return _prefs.getString('token_device') ?? '';
  }

  set tokenDevice(String value) {
    _prefs.setString('token_device', value);
  }

  void loggout() {
    _prefs.setInt('id', 0);
    _prefs.setString('email', '');
    _prefs.setString('card_number', '');
    _prefs.setBool('logged', false);
    _prefs.setString('telephone', '');
  }
}
