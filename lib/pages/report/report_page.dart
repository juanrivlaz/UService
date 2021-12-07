import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/models/graphic_service_model.dart';
import 'package:uService/models/grapich_adviser_model.dart';
import 'package:uService/utils/preference_user.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:uService/widgets/drawer_app.dart';

class ReportPage extends StatefulWidget {
  @override
  ReportState createState() => new ReportState();
}

class ReportState extends State<ReportPage> {
  PreferencesUser pref = new PreferencesUser();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('uService'),
        backgroundColor: Color.fromRGBO(19, 81, 216, 1),
      ),
      drawer: drawerApp(pref),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 24),
                child: Text('Reporte de Ventas', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 34),),
              ),
              Container(
                padding: EdgeInsets.all(36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text('Servicios con cita',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text('total de servicios',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  Container(
                                      child: Text(
                                    '800',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  )),
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text('Paquetes',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  Container(
                                      child: Wrap(
                                    spacing: 12,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              color: Color.fromRGBO(
                                                  34, 204, 226, 1),
                                              margin: EdgeInsets.only(right: 5),
                                            ),
                                            Container(
                                                child: Column(children: [
                                              Container(
                                                child: Text('Basico'),
                                              ),
                                              Container(
                                                  child: Text('300',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)))
                                            ]))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                color: Color.fromRGBO(
                                                    253, 191, 94, 1),
                                                margin:
                                                    EdgeInsets.only(right: 5)),
                                            Container(
                                                child: Column(children: [
                                              Container(
                                                child: Text('Intermedio'),
                                              ),
                                              Container(
                                                  child: Text('400',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)))
                                            ]))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                color: Color.fromRGBO(
                                                    255, 61, 87, 1),
                                                margin:
                                                    EdgeInsets.only(right: 5)),
                                            Container(
                                                child: Column(children: [
                                              Container(
                                                child: Text('Intermedio'),
                                              ),
                                              Container(
                                                  child: Text('100',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)))
                                            ]))
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              child: charts.PieChart([
                                new charts.Series<GraphicServiceModel, String>(
                                    id: 'reception',
                                    colorFn: (GraphicServiceModel service, _) =>
                                        charts.Color.fromHex(
                                            code: '#${service.color}'),
                                    domainFn:
                                        (GraphicServiceModel service, _) =>
                                            service.type,
                                    measureFn:
                                        (GraphicServiceModel service, _) =>
                                            service.quantity,
                                    data: [
                                      new GraphicServiceModel(
                                          'basic', 300, '22cce2'),
                                      new GraphicServiceModel(
                                          'intermedio', 400, 'fdbf5e'),
                                      new GraphicServiceModel(
                                          'avansado', 100, 'ff3d57')
                                    ],
                                    labelAccessorFn:
                                        (GraphicServiceModel service, _) => '')
                              ],
                                  animate: true,
                                  defaultRenderer: new charts.ArcRendererConfig(
                                      arcRendererDecorators: [
                                        new charts.ArcLabelDecorator(
                                            labelPosition:
                                                charts.ArcLabelPosition.auto)
                                      ])),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 24),
                        child: Row(
                          children: [
                            Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      child: Text('Servicios sin cita',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold))),
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text('total de servicios',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  Container(
                                      child: Text(
                                    '800',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  )),
                                  Container(
                                      margin: EdgeInsets.symmetric(vertical: 5),
                                      child: Text('Paquetes',
                                          style:
                                              TextStyle(color: Colors.grey))),
                                  Container(
                                      child: Wrap(
                                    spacing: 12,
                                    children: [
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: 30,
                                              height: 30,
                                              color: Color.fromRGBO(
                                                  34, 204, 226, 1),
                                              margin: EdgeInsets.only(right: 5),
                                            ),
                                            Container(
                                                child: Column(children: [
                                              Container(
                                                child: Text('Basico'),
                                              ),
                                              Container(
                                                  child: Text('300',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)))
                                            ]))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                color: Color.fromRGBO(
                                                    253, 191, 94, 1),
                                                margin:
                                                    EdgeInsets.only(right: 5)),
                                            Container(
                                                child: Column(children: [
                                              Container(
                                                child: Text('Intermedio'),
                                              ),
                                              Container(
                                                  child: Text('400',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)))
                                            ]))
                                          ],
                                        ),
                                      ),
                                      Container(
                                        child: Row(
                                          children: [
                                            Container(
                                                width: 30,
                                                height: 30,
                                                color: Color.fromRGBO(
                                                    255, 61, 87, 1),
                                                margin:
                                                    EdgeInsets.only(right: 5)),
                                            Container(
                                                child: Column(children: [
                                              Container(
                                                child: Text('Intermedio'),
                                              ),
                                              Container(
                                                  child: Text('100',
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold)))
                                            ]))
                                          ],
                                        ),
                                      )
                                    ],
                                  ))
                                ],
                              ),
                            ),
                            Container(
                              width: 200,
                              height: 200,
                              child: charts.PieChart([
                                new charts.Series<GraphicServiceModel, String>(
                                    id: 'reception',
                                    colorFn: (GraphicServiceModel service, _) =>
                                        charts.Color.fromHex(
                                            code: '#${service.color}'),
                                    domainFn:
                                        (GraphicServiceModel service, _) =>
                                            service.type,
                                    measureFn:
                                        (GraphicServiceModel service, _) =>
                                            service.quantity,
                                    data: [
                                      new GraphicServiceModel(
                                          'basic', 300, '22cce2'),
                                      new GraphicServiceModel(
                                          'intermedio', 400, 'fdbf5e'),
                                      new GraphicServiceModel(
                                          'avansado', 100, 'ff3d57')
                                    ],
                                    labelAccessorFn:
                                        (GraphicServiceModel service, _) => '')
                              ],
                                  animate: true,
                                  defaultRenderer: new charts.ArcRendererConfig(
                                      arcRendererDecorators: [
                                        new charts.ArcLabelDecorator(
                                            labelPosition:
                                                charts.ArcLabelPosition.auto)
                                      ])),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                        child: Container(
                      padding: EdgeInsets.all(24),
                      width: MediaQuery.of(context).size.width * .6,
                      height: 400,
                      child: Column(
                        children: [
                          Container(
                            child: Text('Venta por asesor'),
                          ),
                          Container(
                            height: 335,
                            child: charts.BarChart([
                              new charts.Series<GraphicAdviserModel, String>(
                                  id: 'sales',
                                  domainFn: (GraphicAdviserModel service, _) =>
                                      service.name,
                                  measureFn: (GraphicAdviserModel service, _) =>
                                      service.quantity,
                                  data: [
                                    new GraphicAdviserModel('Juan', 300),
                                    new GraphicAdviserModel('Daniel', 400),
                                    new GraphicAdviserModel('Axel', 100),
                                    new GraphicAdviserModel('Ian', 100),
                                    new GraphicAdviserModel('Martha', 500),
                                    new GraphicAdviserModel('Estrella', 30),
                                    new GraphicAdviserModel('Hugo', 100),
                                    new GraphicAdviserModel('Daniela', 600)
                                  ],
                                  labelAccessorFn:
                                      (GraphicAdviserModel service, _) =>
                                          '${service.quantity} K')
                            ],
                                animate: true,
                                barRendererDecorator:
                                    new charts.BarLabelDecorator<String>(
                                        labelPosition:
                                            charts.BarLabelPosition.inside)),
                          )
                        ],
                      ),
                    )),
                    Card(
                        child: Container(
                      padding: EdgeInsets.all(24),
                      child: Column(
                        children: [
                          Center(child: Container(child: Text('Venta Exta de adicionales'))),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                            margin: EdgeInsets.only(top: 24),
                            child: Row(
                              children: [
                                Container(child: Text('KIT DE MOTOR'), margin: EdgeInsets.only(right: 24),),
                                Container(child: Text('\$4,000.00'),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 24),
                            child: Row(
                              children: [
                                Container(child: Text('Limpieza camara de combustion'), margin: EdgeInsets.only(right: 24),),
                                Container(child: Text('\$4,000.00'),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 24),
                            child: Row(
                              children: [
                                Container(child: Text('A/C ODOR'), margin: EdgeInsets.only(right: 24),),
                                Container(child: Text('\$4,000.00'),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 24),
                            child: Row(
                              children: [
                                Container(child: Text('NITROGENO'), margin: EdgeInsets.only(right: 24),),
                                Container(child: Text('\$4,000.00'),)
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 24),
                            child: Row(
                              children: [
                                Container(child: Text('ADICIONAL 2'), margin: EdgeInsets.only(right: 24),),
                                Container(child: Text('\$4,000.00'),)
                              ],
                            ),
                          )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
