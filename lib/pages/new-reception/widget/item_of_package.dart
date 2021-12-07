import 'package:flutter/material.dart';

Widget itemOfPackage(BuildContext context,
    {String name = '', bool isPrincipal = false, @required double width}) {
  return isPrincipal
      ? Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.done,
                size: 27,
                color: Colors.blue,
              ),
              Container(
                margin: EdgeInsets.only(left: 15),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                  name,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                )
              )
            ],
          ),
        )
      : Container(
          width: width,
          padding: EdgeInsets.symmetric(vertical: 12),
          alignment: Alignment.center,
          child: Container(
                margin: EdgeInsets.only(left: 15),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                  name
                ),
                )
              ),
        );
}
