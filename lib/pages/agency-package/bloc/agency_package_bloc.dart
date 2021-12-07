import 'package:rxdart/subjects.dart';
import 'package:uService/models/package_model.dart';

class AgencyPackageBloc {

  BehaviorSubject<List<PackageModel>> _packagesController = BehaviorSubject<List<PackageModel>>();
  BehaviorSubject<bool> _loadingDataController = BehaviorSubject<bool>();
  BehaviorSubject<bool> _loadingSaveController = BehaviorSubject<bool>();

  Stream<List<PackageModel>> get packagesStream => _packagesController.stream;
  Stream<bool> get loadingStream => _loadingDataController.stream;
  Stream<bool> get loadingSaveStream => _loadingSaveController.stream;

  Function(List<PackageModel>) get chagenPackage => _packagesController.sink.add;
  Function(bool) get changeLoadingData => _loadingDataController.sink.add;
  Function(bool) get changeLoadingSave => _loadingSaveController.sink.add;

  List<PackageModel> get packages => _packagesController.valueOrNull ?? [];
  bool get loadingData => _loadingDataController.valueOrNull ?? false;
  bool get loadingSave => _loadingSaveController.valueOrNull ?? false;

  AgencyPackageBloc() {
    this.changeLoadingData(false);
    this.changeLoadingSave(false);
  }

  void clear() {
    this.chagenPackage([]);
    this.changeLoadingData(false);
    this.changeLoadingSave(false);
  }

  void dispose() {
    this._packagesController?.close();
    this._loadingDataController?.close();
    this._loadingSaveController?.close();
  }
}