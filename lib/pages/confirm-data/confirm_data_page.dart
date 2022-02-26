import 'package:flutter/material.dart';

class ConfirmDataPage extends StatefulWidget {

  @override
  ConfirmDataState createState() => new ConfirmDataState();
}

class ConfirmDataState extends State<ConfirmDataPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('uService'),
        backgroundColor: Color.fromRGBO(19, 81, 216, 1),
      ),
      drawer: Drawer(),
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(36),
            child: Card(
              child: Container(
                padding: EdgeInsets.all(24),
                child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 24),
                    child: Text('Order', style: TextStyle(fontSize: 28),),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 12,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'T. Orden',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Numero de Orden',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Hora de Entrega',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 24, top: 24),
                    child: Text('Datos del vehiculo', style: TextStyle(fontSize: 28),),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 12,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Numero de Serie',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Placas',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Marca',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Kilometraje',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Modelo / Tipo',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Motor',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Año Modelo',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .24,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'Color',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 24, top: 24),
                    child: Text('Datos del cliente', style: TextStyle(fontSize: 28),),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 12,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'RFC',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'DOMICILIO',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'COLINIA',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'CIUDAD',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'ESTADO',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'CP',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .418,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'NOMBRE',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 24, top: 24),
                    child: Text('Contacto', style: TextStyle(fontSize: 28),),
                  ),
                  Divider(),
                  Container(
                    margin: EdgeInsets.only(top: 24),
                    child: Wrap(
                      spacing: 24,
                      runSpacing: 12,
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'NOMBRE',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'A. PATERNO',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'A. MATERNO',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'TEL. CASA',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'TEL. OFICINA',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'TEL. CECULAR',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'EMAIL',
                            ),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width * .20,
                          child: TextFormField(
                            autocorrect: false,
                            decoration: new InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.greenAccent, width: 5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey[100], width: 1.0),
                                ),
                                hintText: 'SEXO',
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}