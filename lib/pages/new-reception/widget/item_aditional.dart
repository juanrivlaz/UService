import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

double width(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.portrait) {
    return MediaQuery.of(context).size.width * .9;
  }

  return MediaQuery.of(context).size.width > 700
      ? MediaQuery.of(context).size.width * .55
      : MediaQuery.of(context).size.width;
}

Widget itemAditinal(
  BuildContext context, 
  Function showPresentation,
  { 
    bool isnew = false, 
    bool isrecomendate = false, 
    String name = '', 
    double price = 0,
    @required bool active,
    @required Function(bool) change,
  }
) {
  return Container(
    decoration: BoxDecoration(
      color: isnew ? Colors.green[100].withOpacity(.2) : isrecomendate ? Colors.blue[100].withOpacity(.2) : Colors.white,
      borderRadius: BorderRadius.circular(30)
    ),
    child: CheckboxListTile(
      activeColor: Colors.blue[800],
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: width(context) - 470,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                  name,
                  style: TextStyle(fontSize: 18)
                ),
            ),
          ),
          Container(
            child: Row(
              children: [
                Container(
                  width: 100,
                  child: Text(
                    '\$${NumberFormat.currency(symbol: '').format(price)}',
                    textAlign: TextAlign.end,
                    style: TextStyle(fontSize: 13),
                  ),
                ),
                GestureDetector(
                  onTap: showPresentation,
                  child: Container(
                  margin: EdgeInsets.only(left: 36, right: 24),
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.blue,
                  ),
                  child: Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
                )
              ],
            ),
          )
        ],
      ),
      value: active,
      onChanged: change,
      secondary: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.center, 
            width: 110,
            decoration: BoxDecoration(
              color: isnew ? Colors.green[300] : isrecomendate ? Colors.blue[300] : Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(
              isnew ? 'Nuevo' : isrecomendate ? 'Recomendado' : '',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 12
              ),
            ),
          )
        ],
      ),
    ),
  );
}
