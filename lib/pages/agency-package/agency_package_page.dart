import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:uService/models/agency_model.dart';
import 'package:uService/models/package_model.dart';
import 'package:uService/pages/agency-package/widget/icon_save.dart';
import 'package:uService/services/process/agency_package_process.dart';
import 'package:uService/utils/hex_color.dart';
import 'package:uService/utils/preference_user.dart';

class AgencyPackagePage extends StatefulWidget {

  final AgencyModel agency;

  AgencyPackagePage({@required this.agency});

  @override
  AgencyPackageState createState() => AgencyPackageState();
}

class AgencyPackageState extends State<AgencyPackagePage>
    with AgencyPackageProcess {
  PreferencesUser pref = new PreferencesUser();

  @override
  void initState() {
    super.initState();
    this.init(context, widget.agency);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(19, 81, 216, 1),
        centerTitle: true,
        title: Text(
          widget.agency.name,
          style: TextStyle(color: Colors.white, fontSize: 19),
        ),
        actions: [
          iconSave(this.agencyPackageBloc, this.submit)
        ],
      ),
      backgroundColor: Color.fromRGBO(248, 248, 248, 1),
      body: StreamBuilder(
        stream: this.agencyPackageBloc.loadingStream,
        builder: (BuildContext ctxloading, AsyncSnapshot snploading) {
          if (snploading.hasData && snploading.data) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          return Container(
        margin: EdgeInsets.only(bottom: 36),
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 24),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Text(
                          'Paquetes',
                          style: TextStyle(fontSize: 25),
                        ),
                      ),
                      GestureDetector(
                        onTap: this.addPackage,
                        child: Container(
                          margin: EdgeInsets.only(bottom: 15),
                          width: 35,
                          height: 35,
                          decoration: BoxDecoration(
                              color: Colors.blueAccent,
                              borderRadius: BorderRadius.circular(17.5)),
                          child: Icon(Icons.add, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ),
                Divider(),
                Container(
                  child: StreamBuilder(
                    stream: this.agencyPackageBloc.packagesStream,
                    builder: (BuildContext ctx,
                        AsyncSnapshot<List<PackageModel>> snp) {
                      return Column(
                        children: snp.hasData
                            ? snp.data
                                .asMap()
                                .entries
                                .map((item) => Dismissible(
                                      onDismissed: (direction) {
                                        this.deletePackage(item.key);
                                      },
                                      background: Container(color: Colors.red),
                                      key: Key(item.value.uuid),
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(top: 15),
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: HexColor
                                                                .fromHex(item
                                                                    .value
                                                                    .color),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: HexColor.fromHex(
                                                                item.value
                                                                    .color)
                                                            .withAlpha(68)),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 5,
                                                            horizontal: 15),
                                                    child:
                                                        Text(item.value.name),
                                                  ),
                                                  Expanded(
                                                      child: Divider(
                                                    color: HexColor.fromHex(
                                                        item.value.color),
                                                  )),
                                                  GestureDetector(
                                                    onTap: () => this
                                                        .addSetting(item.key),
                                                    child: Container(
                                                      width: 35,
                                                      height: 35,
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                            color: HexColor
                                                                .fromHex(item
                                                                    .value
                                                                    .color),
                                                            width: 1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(17.5),
                                                      ),
                                                      child: Icon(Icons.add,
                                                          color:
                                                              HexColor.fromHex(
                                                                  item.value
                                                                      .color)),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 25),
                                              child: Column(
                                                children: item.value.settings
                                                    .asMap()
                                                    .entries
                                                    .map(
                                                        (setting) =>
                                                            Dismissible(
                                                              onDismissed:
                                                                  (direction) {
                                                                this.deleteSetting(
                                                                    item.key, setting.key);
                                                              },
                                                              background:
                                                                  Container(
                                                                      color: Colors
                                                                          .red),
                                                              key: Key(setting.value.uuid),
                                                              child:
                                                                  ExpansionTile(
                                                                collapsedIconColor:
                                                                    HexColor.fromHex(item
                                                                        .value
                                                                        .color),
                                                                iconColor: HexColor
                                                                    .fromHex(item
                                                                        .value
                                                                        .color),
                                                                title:
                                                                    Container(
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      Container(
                                                                        child: Text(
                                                                            setting.value.yearInitial
                                                                                .toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.black54)),
                                                                      ),
                                                                      Container(
                                                                        child: Text(
                                                                            setting.value.yearFinish
                                                                                .toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.black54)),
                                                                      ),
                                                                      Container(
                                                                        child: Text(
                                                                            setting.value.kmInitial
                                                                                .toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.black54)),
                                                                      ),
                                                                      Container(
                                                                        child: Text(
                                                                            setting.value.everyKm
                                                                                .toString(),
                                                                            style:
                                                                                TextStyle(color: Colors.black54)),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                children: [
                                                                  Container(
                                                                    child:
                                                                        Column(
                                                                      children: setting.value.products.asMap().entries.map((product) => Dismissible(
                                                                            onDismissed:
                                                                                (direction) {
                                                                              this.deleteProduct(item.key, setting.key, product.key);
                                                                            },
                                                                            background:
                                                                                Container(
                                                                              color: Colors.red,
                                                                            ),
                                                                            key:
                                                                                Key(product.value.uuid),
                                                                            child: ListTile(
                                                                              title: Text(product.value.name),
                                                                              trailing: Text('\$${NumberFormat.currency(symbol: '').format(product.value.price)}'),
                                                                            ))).toList()
                                                                      ,
                                                                    ),
                                                                  ),
                                                                  Container(
                                                                    decoration: BoxDecoration(
                                                                      border: Border(top: BorderSide(color: Colors.black12, width: 1))
                                                                    ),
                                                                    padding: EdgeInsets.symmetric(
                                                                        vertical: 15,
                                                                        horizontal: 5),
                                                                    child: Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        IconButton(onPressed: () => this.editSetting(item.key, setting.key, setting.value), icon: Icon(Icons.edit, color: Colors.black38)),
                                                                        SizedBox(width: 25,),
                                                                        IconButton(onPressed: () => this.addProducts(item.key, setting.key, setting.value), icon: Icon(Icons.add_circle, color: Colors.black38))
                                                                      ],
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ))
                                                    .toList(),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ))
                                .toList()
                            : [],
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      );
        },
      ),
    );
  }
}
