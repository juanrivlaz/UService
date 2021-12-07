import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uService/models/product_model.dart';
import 'package:uService/pages/agency-package/bloc/setting_bloc.dart';

void selectProducts(ProductModel product, SettingBloc bloc, bool value) {
  var products = bloc.products;

  bool exist = selectedProduct(product, bloc);

  if (!exist) {
    products.add(product);
  } else {
    int index = products.indexWhere((element) => element.id == product.id);
    products.removeAt(index);
  }

  bloc.changeProducts(products);
}

bool selectedProduct(ProductModel product, SettingBloc bloc) {
  int index = bloc.products.indexWhere((element) => element.id == product.id);
  return index >= 0;
}

Widget dialogProducts(
    BuildContext context, SettingBloc bloc, Function close, Function submit,
    {List<ProductModel> products}) {
  return Dialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
    child: Container(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 400,
            height: 520,
            child: Container(
                padding: EdgeInsets.symmetric(vertical: 24, horizontal: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Center(
                            child: Text('PRODUCTOS',
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 19)),
                          ),
                          SizedBox(height: 20),
                          Container(
                            height: 356,
                              child: SingleChildScrollView(
                                physics: BouncingScrollPhysics(),
                                child: StreamBuilder(
                                  stream: bloc.productStream,
                                  builder:
                                      (BuildContext ctx, AsyncSnapshot snp) {
                                    return Column(
                                      children: products
                                          .map((product) => Container(
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                      bottom: BorderSide(
                                                          color: Colors.black12,
                                                          width: 1))),
                                              child: ListTile(
                                                leading: Checkbox(
                                                  onChanged: (bool value) =>
                                                      selectProducts(
                                                          product, bloc, value),
                                                  value: selectedProduct(
                                                      product, bloc),
                                                ),
                                                title: Text(product.name),
                                                trailing: Text('\$${NumberFormat.currency(symbol: '').format(product.price)}'),
                                              )))
                                          .toList(),
                                    );
                                  }),
                              ),
                              )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: submit,
                          child: Text('Guardar',
                              style: TextStyle(color: Colors.white)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.symmetric(vertical: 15)),
                              backgroundColor: MaterialStateProperty.all(
                                  Color.fromRGBO(19, 81, 216, 1)),
                              elevation: MaterialStateProperty.all(0),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(20))))),
                    )
                  ],
                ),
              ),
          ),
          Positioned(
              top: -10,
              right: -10,
              child: GestureDetector(
                onTap: close,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.redAccent),
                  padding: EdgeInsets.all(10),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ))
        ],
      ),
    ),
  );
}
