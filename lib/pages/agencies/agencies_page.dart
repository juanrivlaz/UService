import 'package:flutter/material.dart';
import 'package:uService/pages/agencies/widget/table.dart';
import 'package:uService/services/process/agencies_process.dart';
import 'package:uService/utils/preference_user.dart';
import 'package:uService/widgets/drawer_app.dart';

class AgenciesPage extends StatefulWidget {
  @override
  AgenciesState createState() => new AgenciesState();
}

class AgenciesState extends State<AgenciesPage> with AgenciesProcess {
  PreferencesUser pref = new PreferencesUser();

  @override
  void initState() {
    super.initState();

    this.init(context);
    pref.activeRoute = 'agencies';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      appBar: AppBar(
        title: Text('AGENCIAS'),
        centerTitle: true,
        elevation: 0,
      ),
      drawer: drawerApp(pref),
      body: Container(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
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
                margin: EdgeInsets.only(top: 50, bottom: 30),
                width: this.width > 600 ? this.width * .9 : this.width,
                child: table(this.agencyBloc, this.width, this.editAgency),
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: this.addAgency,
      ),
    );
  }
}
