import 'package:rxdart/rxdart.dart';
import 'package:uService/utils/validators.dart';

class LoginBloc with Validators {
  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _loadingController = BehaviorSubject<bool>();

  Stream<String> get emailStream =>
      _emailController.stream.transform(validateEmpty);
  Stream<String> get passwordStream =>
      _passwordController.stream.transform(validateEmpty);
  Stream<bool> get loadingStream => _loadingController.stream;
  Stream<bool> get formValidStream =>
      Rx.combineLatest2(emailStream, passwordStream, (a, b) => true);

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;
  Function(bool) get changeLoading => _loadingController.sink.add;

  String get email => _emailController.value;
  String get password => _passwordController.value;
  bool get loading => _loadingController.value;

  LoginBloc() {
    this._loadingController.sink.add(false);
  }

  Map<String, dynamic> toJson() {
    return {
      'username': this.email,
      'password': this.password
    };
  }

  dispose() {
    _emailController?.close();
    _passwordController?.close();
    _loadingController?.close();
  }
}
