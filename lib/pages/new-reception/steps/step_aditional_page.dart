import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/models/product_model.dart';
import 'package:uService/pages/new-reception/bloc/reception_bloc.dart';
import 'package:uService/pages/new-reception/widget/item_aditional.dart';

double width(BuildContext context) {

  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.width * .9;
  }

  return MediaQuery.of(context).size.width > 700
      ? MediaQuery.of(context).size.width * .55
      : MediaQuery.of(context).size.width;
}

double fullWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

Widget aditionals(BuildContext context, ReceptionBloc bloc, Function(String link) showPresentation, { @required List<ProductModel> products }) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: 25, bottom: 70),
          child: Text(
            'Cuidados del Vehículo Adicionales',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 25),
          width: width(context),
          child: StreamBuilder(
            stream: bloc.additionalStream,
            builder: (BuildContext ctxaditional, AsyncSnapshot<List<ProductModel>> snpaditional) {
              return Wrap(
                spacing: 5,
                runSpacing: 5,
                children: products.map((product) => Column(children: [
                  itemAditinal(
                    context, 
                    () => showPresentation(product.linkPathPresentation), 
                    isnew: false, 
                    isrecomendate: true, 
                    name: product.name, 
                    price: product.price,
                    active: snpaditional.hasData ? snpaditional.data.contains(product) : false,
                    change: (bool value) {
                      if (value) {
                        bloc.aditional.add(product);
                        bloc.changeAdditional(bloc.aditional);
                      } else {
                        bloc.changeAdditional(bloc.aditional.where((element) => element.id != product.id).toList());
                      }

                      bloc.updateResume();
                    }
                  ),
                  Divider(),
                ])).toList()
              );
            },
          ),
        )
      ],
    ),
  );
}
