import 'package:flutter/material.dart';

Widget indicatorStep(double currentPage) {
  return Wrap(
    alignment: WrapAlignment.center,
    crossAxisAlignment: WrapCrossAlignment.center,
    spacing: 10,
    children: [
      Container(
        width: 60,
        height: 8,
        color: currentPage == 0 ? Colors.blue[600] : Colors.green[200],
      ),
      Container(
        width: 60,
        height: 8,
        color: currentPage == 1
            ? Colors.blue[600]
            : currentPage > 1
                ? Colors.green[200]
                : Colors.black12,
      ),
      Container(
        width: 60,
        height: 8,
        color: currentPage == 2
            ? Colors.blue[600]
            : currentPage > 2
                ? Colors.green[200]
                : Colors.black12,
      ),
      Container(
        width: 60,
        height: 8,
        color: currentPage == 3
            ? Colors.blue[600]
            : currentPage > 3
                ? Colors.green[200]
                : Colors.black12,
      ),
      Container(
        width: 60,
        height: 8,
        color: currentPage == 4
            ? Colors.blue[600]
            : currentPage > 4
                ? Colors.green[200]
                : Colors.black12,
      ),
      Container(
        width: 60,
        height: 8,
        color: currentPage == 5
            ? Colors.blue[600]
            : currentPage > 5
                ? Colors.green[200]
                : Colors.black12,
      )
    ],
  );
}
