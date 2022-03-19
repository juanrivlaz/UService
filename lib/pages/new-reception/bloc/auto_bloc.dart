import 'package:rxdart/rxdart.dart';
import 'package:uService/models/DMS/marca_model.dart';
import 'package:uService/models/DMS/vehicle_model.dart';
import 'package:uService/utils/validators.dart';

class AutoBloc with Validators {

  BehaviorSubject<String> _serieController = BehaviorSubject<String>();
  BehaviorSubject<String> _placaController = BehaviorSubject<String>();
  BehaviorSubject<String> _colorController = BehaviorSubject<String>();
  BehaviorSubject<int> _marcaController = BehaviorSubject<int>();
  BehaviorSubject<int> _modelController = BehaviorSubject<int>();
  BehaviorSubject<String> _motorController = BehaviorSubject<String>();
  BehaviorSubject<String> _cilindrosController = BehaviorSubject<String>();
  BehaviorSubject<int> _yearController = BehaviorSubject<int>();
  BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>();
  BehaviorSubject<bool> _loadingDataController = BehaviorSubject<bool>();

  Stream<String> get serieStream => _serieController.stream.transform(validateEmpty);
  Stream<String> get placaStream => _placaController.stream.transform(validateEmpty);
  Stream<String> get colorStream => _colorController.stream;
  Stream<int>    get marcaStream => _marcaController.stream.transform(validNumber);
  Stream<int>    get modelStream => _modelController.stream.transform(validNumber);
  Stream<String> get motorStream => _motorController.stream;
  Stream<int>    get yearStream  => _yearController.stream.transform(validNumber);
  Stream<String> get cilindrosStream => _cilindrosController.stream;
  Stream<bool>   get loadingStream => _loadingController.stream;
  Stream<bool>   get loadingDataStream => _loadingDataController.stream;

  Stream<bool> get formValidStream => Rx.combineLatest4(
    placaStream,
    marcaStream,
    modelStream,
    yearStream, (a, b, c, d) => true);

  Function(String) get changeSerie => _serieController.sink.add;
  Function(String) get changePlaca => _placaController.sink.add;
  Function(String) get changeColor => _colorController.sink.add;
  Function(int)    get changeMarca => _marcaController.sink.add;
  Function(int)    get changeModel => _modelController.sink.add;
  Function(String) get changeMotor => _motorController.sink.add;
  Function(int)    get changeYear  => _yearController.sink.add;
  Function(String) get changeCilindros => _cilindrosController.sink.add;
  Function(bool)   get changeLoading => _loadingController.sink.add;
  Function(bool)   get changeLoadingData => _loadingDataController.sink.add;

  String get serie => _serieController.valueOrNull ?? '';
  String get placa => _placaController.valueOrNull ?? '';
  String get color => _colorController.valueOrNull ?? '';
  int    get marca => _marcaController.valueOrNull ?? 0;
  int    get model => _modelController.valueOrNull ?? 0;
  String get motor => _motorController.valueOrNull ?? '';
  int    get year  => _yearController.valueOrNull ?? 0;
  String get cilindros => _cilindrosController.valueOrNull ?? '';

  AutoBloc() {
    this.changeLoading(false);
    this.changeLoadingData(false);
    this.changeMarca(1);
  }

  void clear() {
    this._serieController = BehaviorSubject<String>();
    this._placaController = BehaviorSubject<String>();
    this._colorController = BehaviorSubject<String>();
    this._marcaController = BehaviorSubject<int>();
    this._modelController = BehaviorSubject<int>();
    this._motorController = BehaviorSubject<String>();
    this._cilindrosController = BehaviorSubject<String>();
    this._yearController = BehaviorSubject<int>();
  }

  Map<String, String> toJson() {
    return {
      'serie': serie,
      'placa': placa,
      'color': color,
      'marca': marca.toString(),
      'model': model.toString(),
      'year' : year.toString(),
      'cilindros': cilindros
    };
  }

  VehicleModel toModel(List<MarcaModel> marcas) {
    var marcaFind = marcas.firstWhere((element) => element.id == marca);
    var modelFind = marcaFind.models.firstWhere((element) => element.id == model);

    return VehicleModel.fromJson(
      {
        'id': '${DateTime.now().minute}${DateTime.now().second}',
        'serie': serie,
        'placas': placa ?? '-',
        'color': color,
        'marca': marcaFind,
        'model': modelFind.toJson(),
        'year' : year ?? 2017,
        'cilindros': cilindros
      }
    );
  }

  void disponse()
  {
    _serieController?.close();
    _placaController?.close();
    _colorController?.close();
    _marcaController?.close();
    _modelController?.close();
    _motorController?.close();
    _yearController?.close();
    _cilindrosController?.close();
    _loadingController?.close();
    _loadingDataController?.close();
  }
}