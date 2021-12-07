import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:uService/models/package_model.dart';
import 'package:uService/utils/validators.dart';

class PackageBloc with Validators {

  BehaviorSubject<String> _nameController = BehaviorSubject<String>();
  BehaviorSubject<String> _colorController = BehaviorSubject<String>();
  BehaviorSubject<bool> _loadingController = BehaviorSubject<bool>();

  Stream<String> get nameStream => _nameController.stream.transform(validateEmpty);
  Stream<String> get colorStream => _colorController.stream.transform(validHexadecimal);
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<bool> get formValidStream => Rx.combineLatest2(nameStream, colorStream, (a, b) => true);

  Function(String) get changeName => _nameController.sink.add;
  Function(String) get changeColor => _colorController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  String get name => _nameController.valueOrNull ?? '';
  String get color => _colorController.valueOrNull ?? '';
  bool get loading => _loadingController.valueOrNull ?? false;

  PackageBloc() {
    this.changeLoading(false);
  }

  PackageModel toModel() {
    PackageModel model = new PackageModel();

    model.name = this.name;
    model.color = this.color;

    return model;
  }

  void clear() {
    this._nameController = BehaviorSubject<String>();
    this._colorController = BehaviorSubject<String>();
    this.changeLoading(false);
  }

  void dispose()
  {
    this._nameController?.close();
    this._colorController?.close();
    this._loadingController?.close();
  }

}