import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uService/models/car_section_model.dart';

Widget itemCheck(
  BuildContext context, 
  Function(int) changeStatus,
  {CarSectionModel section}) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            section.label,
            style: TextStyle(fontSize: 20),
          ),
        ),
        Container(
          child: Wrap(
            spacing: 20,
            children: [
              Container(
                child: IconButton(
                    onPressed: () => changeStatus(0),
                    icon: Icon(
                      Icons.check_circle_rounded,
                      size: 30,
                      color: section.status == 0 ? Colors.green : null,
                    )),
              ),
              Container(
                child: IconButton(
                    onPressed: () => changeStatus(1),
                    icon: Icon(
                      Icons.warning_amber_rounded,
                      size: 30,
                      color: section.status == 1 ? Colors.orange : null
                    )),
              ),
              Container(
                child: IconButton(
                    onPressed: () => changeStatus(2),
                    icon: Icon(
                      Icons.close, 
                      size: 30,
                      color: section.status == 2 ? Colors.red : null
                    )),
              )
            ],
          ),
        )
      ],
    ),
  );
}
