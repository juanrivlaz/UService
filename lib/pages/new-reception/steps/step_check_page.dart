import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/models/car_section_model.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';
import 'package:uService/pages/new-reception/widget/item_check.dart';

double width(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.width * .9;
  }

  return MediaQuery.of(context).size.width > 700
      ? MediaQuery.of(context).size.width * .55
      : MediaQuery.of(context).size.width;
}

Widget checks(
  BuildContext context, 
  ReceptionBloc bloc, 
  List<CarSectionModel> sections) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.all(25),
          child: Text(
            'CHECK',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          width: width(context),
          child: StreamBuilder(
            stream: bloc.carSectionStream,
            builder: (BuildContext ctxCheck, AsyncSnapshot<List<CarSectionModel>> snpCheck) {
              List<CarSectionModel> sectionsbloc = snpCheck.hasData ? snpCheck.data : [];

              return Wrap(
                runSpacing: 18,
                children: sections.map((section) => Column(
                  children: [
                    itemCheck(context, (int status) {
                      section.status = status;

                      if (status == 0) {
                        sectionsbloc = sectionsbloc.where((element) => element.id != section.id).toList();
                      } else {
                        var index = sectionsbloc.indexWhere((element) => element.id == section.id);
                        if (index > 0) {
                          sectionsbloc[index].status = status;
                        } else {
                          sectionsbloc.add(section);
                        }
                      }

                      bloc.changeCarSection(sectionsbloc);
                    },
                    section: section),
                    Divider(),
                  ]
                )).toList()
              );
            },
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: StreamBuilder(
            stream: bloc.imagesStream,
            builder: (BuildContext ctximages, AsyncSnapshot snpimages) {
              List<File> images = snpimages.hasData ? snpimages.data : [];

              return Wrap(
              spacing: 24,
              runSpacing: 24,
              children: images
                  .map((image) => Container(
                      width: 150,
                      height: 150,
                      color: Colors.grey[100],
                      child: Center(
                        child: Image.file(image)
                        )
                      ))
                  .toList());
            },
          ),
        ),
        Container(
          width: width(context),
          margin: EdgeInsets.symmetric(vertical: 24),
          child: StreamBuilder(
            stream: bloc.tecnicalCommentStream,
            builder: (BuildContext ctxtechnical, AsyncSnapshot snptechnical) {
              return TextField(
                controller: bloc.technicalCommentController,
                keyboardType: TextInputType.multiline,
                maxLines: 8,
                decoration: InputDecoration(
                    hintText: "Observación Técnica",
                    enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey))),
                onChanged: bloc.changeTechnicalComment,
              );
            },
          ),
        )
      ],
    ),
  );
}
