import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/pages/new-reception/steps/step_aditional_page.dart';
import 'package:uService/pages/new-reception/steps/step_check_page.dart';
import 'package:uService/pages/new-reception/steps/step_client_page.dart';
import 'package:uService/pages/new-reception/steps/step_init_page.dart';
import 'package:uService/pages/new-reception/steps/step_km_page.dart';
import 'package:uService/pages/new-reception/steps/step_package_page.dart';
import 'package:uService/pages/new-reception/widget/indicator_step.dart';
import 'package:uService/services/process/reception_vehicle_process.dart';
import 'package:uService/utils/preference_user.dart';

class NewReceptionPage extends StatefulWidget {
  @override
  NewReceptionState createState() => new NewReceptionState();
}

class NewReceptionState extends State<NewReceptionPage>
    with ReceptionVehicleProcess {
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

  void next() => animateScroll(this._currentPage.round() + 1);

  void previous() => animateScroll(this._currentPage.round() - 1);

  void pageChange(int value) => setState(() => this._currentPage = value * 1.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('uService'),
        backgroundColor: Color.fromRGBO(19, 81, 216, 1),
        leading:
            IconButton(onPressed: previous, icon: Icon(Icons.arrow_back_ios)),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done))],
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
                                    child: NotificationListener<
                                        ScrollNotification>(
                                  onNotification: _onScroll,
                                  child: PageView(
                                    reverse: false,
                                    scrollDirection: Axis.horizontal,
                                    controller: this._pageController,
                                    onPageChanged: this.pageChange,
                                    children: [
                                      init(context, this.bloc, this.typesService),
                                      client(context, this.bloc),
                                      km(context, this.bloc, this.getSettingsPackage),
                                      package(context, this.bloc, this.packages),
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
