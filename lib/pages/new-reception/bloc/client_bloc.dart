import 'package:rxdart/rxdart.dart';
import 'package:uService/models/DMS/client_model.dart';
import 'package:uService/utils/validators.dart';

class ClientBloc with Validators {
  BehaviorSubject<String> _rfcController = BehaviorSubject<String>();
  BehaviorSubject<String> _addressControtroller = BehaviorSubject<String>();
  BehaviorSubject<String> _colonyController = BehaviorSubject<String>();
  BehaviorSubject<String> _cityController = BehaviorSubject<String>();
  BehaviorSubject<String> _stateController = BehaviorSubject<String>();
  BehaviorSubject<String> _postcodeController = BehaviorSubject<String>();
  BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>();

  Stream<String> get rfcStream => _rfcController.stream.transform(validateEmpty);
  Stream<String> get addressStream => _addressControtroller.stream;
  Stream<String> get colonyStream => _colonyController.stream;
  Stream<String> get cityStream => _cityController.stream;
  Stream<String> get stateStream => _stateController.stream;
  Stream<String> get postcodeStream => _postcodeController.stream;
  Stream<String> get nameStream => _nameController.stream.transform(validateEmpty);
  Stream<bool>   get loadingStream => _loadingController.stream;

  Stream<bool> get fromValidStream => Rx.combineLatest2(rfcStream, nameStream, (a, b) => true);

  Function(String) get changeRfc => _rfcController.sink.add;
  Function(String) get changeAddress => _addressControtroller.sink.add;
  Function(String) get changeColony => _colonyController.sink.add;
  Function(String) get changeCity => _cityController.sink.add;
  Function(String) get changeState => _stateController.sink.add;
  Function(String) get changePostcode => _postcodeController.sink.add;
  Function(String) get changeName => _nameController.sink.add;
  Function(bool)   get changeLoading => _loadingController.sink.add;

  String get rfc => _rfcController.valueOrNull ?? '';
  String get address => _addressControtroller.valueOrNull ?? '';
  String get colony => _colonyController.valueOrNull ?? '';
  String get city => _cityController.valueOrNull ?? '';
  String get state => _stateController.valueOrNull ?? '';
  String get postcode => _postcodeController.valueOrNull ?? '';
  String get name => _nameController.valueOrNull ?? '';

  ClientBloc() {
    changeLoading(false);
  }

  ClientModel toModel() {
    return ClientModel.fromJson({
      'id': -1,
      'rfc': rfc,
      'address': address,
      'colony': colony,
      'city': city,
      'state': state,
      'postcode': postcode,
      'name': name
    });
  }

  void clear() {
    _rfcController = BehaviorSubject<String>();
    _addressControtroller = BehaviorSubject<String>();
    _colonyController = BehaviorSubject<String>();
    _cityController = BehaviorSubject<String>();
    _stateController = BehaviorSubject<String>();
    _postcodeController = BehaviorSubject<String>();
    _nameController = BehaviorSubject<String>();
  }

  void dispose()
  {
    _rfcController?.close();
    _addressControtroller?.close();
    _colonyController?.close();
    _cityController?.close();
    _stateController?.close();
    _postcodeController?.close();
    _nameController?.close();
    _loadingController?.close();
  }
}