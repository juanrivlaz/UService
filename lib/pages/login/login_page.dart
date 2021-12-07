import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/pages/login/bloc/login_bloc.dart';
import 'package:uService/pages/login/widget/button_submit.dart';
import 'package:uService/pages/login/widget/input_password.dart';
import 'package:uService/pages/login/widget/input_username.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/rest_service.dart';
import 'package:uService/services/setup_service.dart';
import 'package:uService/utils/preference_user.dart';

class LoginPage extends StatefulWidget {
  @override
  LoginState createState() => new LoginState();
}

class LoginState extends State<LoginPage> {

  PreferencesUser pref = new PreferencesUser();
  final LoginBloc form = new LoginBloc();

  @override
  void initState() {
    super.initState();
    pref.activeRoute = 'login';
  }

  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  void submit() {
    this.form.changeLoading(true);

    appService<RestService>().login(username: this.form.email, password: this.form.password).then((value) {
      appService<NavigationService>().navigateTo('agencies');
    }, onError: (err) {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        duration: Duration(seconds: 3),
        content: Text(
            err is String ? err : 'Error al consultar la información'),
      ));
    }).whenComplete(() => this.form.changeLoading(false));
  }

  @override
    Widget build(BuildContext context) {
      
      return Scaffold(
        backgroundColor: Color.fromRGBO(19, 81, 216, 1),
        body: Center(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: this.width(context) > 600 ? 400 : this.width(context),
            color: Color.fromRGBO(19, 81, 216, 1),
            padding: EdgeInsets.symmetric(horizontal: 40),
            child: Center(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(24),
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                  Container(
                    child: Text('U', style: TextStyle(
                      color: Color.fromRGBO(19, 81, 216, 1),
                      fontSize: 60,
                      fontWeight: FontWeight.bold
                    )),
                  ),
                  Container(
                    child: Text('Service', style: TextStyle(
                      color: Color.fromRGBO(19, 81, 216, 1),
                      fontSize: 20
                    )),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 48),
                    child: inputUsername(this.form),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: inputPassword(this.form),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 24, bottom: 24),
                    child: Text('¿Olvidaste tu contraseña?', style: TextStyle(color: Colors.grey, fontSize: 13)),
                  ),
                  Container(
                    child: SizedBox(
                      width: double.infinity,
                      child: buttonSubmit(this.form, this.submit),
                    )
                  )
                ],
                ),
                ),
              ),
            )
          ),
        )
      );
    }
}