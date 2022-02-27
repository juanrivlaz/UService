import 'package:flutter/material.dart';
import 'package:uService/pages/new-reception/bloc/auto_bloc.dart';
import 'package:uService/pages/new-reception/bloc/client_bloc.dart';
import 'package:uService/pages/new-reception/steps/step_aditional_page.dart';
import 'package:uService/pages/new-reception/steps/step_check_page.dart';
import 'package:uService/pages/new-reception/steps/step_client_page.dart';
import 'package:uService/pages/new-reception/steps/step_init_page.dart';
import 'package:uService/pages/new-reception/steps/step_km_page.dart';
import 'package:uService/pages/new-reception/steps/step_package_page.dart';
import 'package:uService/pages/new-reception/widget/dialog_create_auto.dart';
import 'package:uService/pages/new-reception/widget/dialog_create_client.dart';
import 'package:uService/pages/new-reception/widget/indicator_step.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/process/reception_vehicle_process.dart';
import 'package:uService/services/setup_service.dart';
import 'package:uService/utils/preference_user.dart';

class NewReceptionPage extends StatefulWidget {
  @override
  NewReceptionState createState() => new NewReceptionState();
}

class NewReceptionState extends State<NewReceptionPage>
    with ReceptionVehicleProcess 
{

  AutoBloc autoBloc = new AutoBloc();
  ClientBloc clientBloc = ClientBloc();
  PreferencesUser pref = new PreferencesUser();
  PageController _pageController = PageController(initialPage: 0);
  double _currentPage = 0.0;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    this.pref.activeRoute = 'agencies';
    this.init(context);
  }

  Future<void> animateScroll(int page) async {
    setState(() => this._isScrolling = true);

    await this._pageController.animateToPage(page,
        duration: Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn);

    if (mounted) {
      setState(() => this._isScrolling = false);
    }
  }

  bool _onScroll(ScrollNotification notification) {
    final metrics = notification.metrics;

    if (metrics is PageMetrics && metrics.page != null && mounted) {
      setState(() => this._currentPage = metrics.page);
    }

    return false;
  }

  void next() {
    if (_currentPage == 0 && !(bloc.typeService > 0 && bloc.validVehicle)) {
      showAlert('Selecciona un tipo de servicio y un vehiculo.');
      
      return;
    } else if (_currentPage == 1) {
      var auto = bloc.vehicleModel;
      if (auto.client.id == 0) {
        showAlert('Selecciona un cliente.');

        return;
      }
    } else if (_currentPage == 2 && bloc.kmService == 0) {
      showAlert('Selecciona un kilometraje.');

      return;
    } else {
      animateScroll(this._currentPage.round() + 1);
    }

    animateScroll(this._currentPage.round() + 1);
  }

  void previous() => animateScroll(this._currentPage.round() - 1);

  void pageChange(int value) => setState(() => this._currentPage = value * 1.0);

  void addAuto() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) => dialogCreateAuto(
        context, 
        autoBloc,
        marcas,
        () async {
          autoBloc.changeLoading(true);
          await Future.delayed(Duration(seconds: 2));

          var model = autoBloc.toModel(marcas);
          var autos = this.bloc.vehicles;
          autos.add(model);
          this.bloc.changeVehicles(autos);

          bloc.changeVehicle(model);
          bloc.updateResume();

          Navigator.of(context).pop();
          autoBloc.clear();
          autoBloc.changeLoading(false);
        },
        () => {
          Navigator.of(context).pop()
        }
      )
    );
  }

  void addClient() async {
    await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext ctx) => dialogCreateClinet(
        context,
        clientBloc,
        () async {
          clientBloc.changeLoading(true);
          await Future.delayed(Duration(seconds: 2));
          var client = clientBloc.toModel();

          bloc.changeClient(client);

          var clients = bloc.clients;
          clients.add(client);
          bloc.changeClients(clients);

          var auto = bloc.vehicleModel;
          auto.client = client;
          bloc.changeVehicle(auto);
          bloc.updateResume();

          Navigator.of(context).pop();
          clientBloc.clear();
          clientBloc.changeLoading(false);
        },
        () => {
          Navigator.of(context).pop()
        }
      )
    );
  }

  void showAlert(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: Colors.redAccent,
      content: Text(message, textAlign: TextAlign.center),
    ));
  }

  void showSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        dismissDirection: DismissDirection.up,
        backgroundColor: Colors.green,
        content: Text('Su registro fue agregado correctamente', textAlign: TextAlign.center),
      )
    );
  }

  List<int> getKilometrajes() {
    List<int> kilometrajes = [];
    kilometrajes.add(5000);
    kilometrajes.addAll(List<int>.generate(30, (index) => (index + 1) * 10000 ));

    return kilometrajes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('uService'),
        backgroundColor: Color.fromRGBO(19, 81, 216, 1),
        leading: _currentPage >= 1 ? IconButton(onPressed: previous, icon: Icon(Icons.arrow_back_ios)) : null,
        actions: [
          IconButton(
            onPressed: _currentPage == 5 ? () {
              showSuccess();
              appService<NavigationService>().goBack();
            } : next,
            icon: Icon(_currentPage == 5 ? Icons.done : Icons.navigate_next, size: _currentPage == 5 ? null : 35,)
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                  child: Column(children: [
                Container(
                  height: 10,
                  width: MediaQuery.of(context).size.width,
                  margin: EdgeInsets.all(25),
                  child: indicatorStep(this._currentPage),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  color: Color.fromRGBO(240, 240, 240, 1),
                  height: 60,
                  child: Center(
                    child: StreamBuilder(
                      stream: bloc.resumetextStream,
                      builder: (BuildContext cxtresume, AsyncSnapshot snpresult) {
                        return Text(
                          snpresult.hasData ? snpresult.data : 'Sin Vehiculo',
                          style: TextStyle(color: Colors.black54),
                        );
                      },
                    ),
                  ),
                )
              ])),
              Container(
                  height: MediaQuery.of(context).size.height - 200,
                  child: StreamBuilder(
                    stream: this.bloc.loadingDataStream,
                    builder: (BuildContext ctxloadingdata,
                        AsyncSnapshot snploadingdata) {
                      return snploadingdata.hasData && snploadingdata.data
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : Stack(
                              children: [
                                Positioned.fill(
                                  child: NotificationListener<ScrollNotification>(
                                  onNotification: _onScroll,
                                  child: PageView(
                                    physics: NeverScrollableScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    controller: this._pageController,
                                    onPageChanged: this.pageChange,
                                    children: [
                                      init(
                                        context,
                                        this.bloc,
                                        this.typesService,
                                        addAuto
                                      ),
                                      client(
                                        context,
                                        this.bloc,
                                        addClient
                                      ),
                                      km(
                                        context,
                                        getKilometrajes(),
                                        this.bloc,
                                        this.getSettingsPackage,
                                        next
                                      ),
                                      package(context, this.bloc, this.packages, next),
                                      aditionals(context, this.bloc, this.showPresentation, products: this.products),
                                      checks(context, this.bloc, this.carSections)
                                    ],
                                  ),
                                ))
                              ],
                            );
                    },
                  ))
            ],
          ),
        ),
      ),
      floatingActionButton: this._currentPage == 5
          ? FloatingActionButton(
              onPressed: this.captureImage,
              child: Icon(Icons.camera_alt),
            )
          : null,
    );
  }

  @override
  void dispose() {
    super.dispose();
    this.bloc.dispose();
  }
}
