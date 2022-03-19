import 'package:flutter/material.dart';
import 'package:uService/pages/reception/widget/table.dart';
import 'package:uService/services/navigation_serice.dart';
import 'package:uService/services/setup_service.dart';
import 'package:uService/utils/preference_user.dart';
import 'package:uService/widgets/drawer_app.dart';

class ReceptionPage extends StatefulWidget {
  @override
  ReceptionState createState() => new ReceptionState();
}

class ReceptionState extends State<ReceptionPage> {
  PreferencesUser pref = new PreferencesUser();
  double iconSize = 40;

  @override
  void initState() {
    super.initState();
    pref.activeRoute = 'reception';
  }

  void showListVehicle(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext ctx) {
          return SafeArea(
              child: Container(
            child: new Wrap(
              children: [
                ListTile(
                  title: Text('JNU8093'),
                  subtitle: Text('MAZDA 3, 2017'),
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ));
        });
  }

  double width(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        title: Text('RECEPCIÓNES'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: drawerApp(pref),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                      padding: EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      color: Theme.of(context).primaryColor),
                  Positioned(
                      bottom: -25,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12),
                                height: 50,
                                width: MediaQuery.of(context).size.width * .8,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3.0),
                                    color: Colors.white),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width:
                                          (MediaQuery.of(context).size.width *
                                                  .8) -
                                              60,
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        enableSuggestions: false,
                                        autocorrect: false,
                                        style: TextStyle(color: Colors.black87),
                                        decoration: InputDecoration(
                                            border: InputBorder.none,
                                            focusedBorder: InputBorder.none,
                                            enabledBorder: InputBorder.none,
                                            errorBorder: InputBorder.none,
                                            disabledBorder: InputBorder.none,
                                            contentPadding: EdgeInsets.only(
                                                bottom: 11, top: 11),
                                            hintText: "BUSCAR"),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        print('Buscar');
                                      },
                                      child: Container(
                                        child: Icon(Icons.search),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ]),
                      ))
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 50),
                width: this.width(context) > 600
                    ? this.width(context) * .8
                    : this.width(context),
                child:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: table(context),
                          )
                        : table(context),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => appService<NavigationService>().navigateTo('reception')),
    );
  }
}
