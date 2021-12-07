import 'package:flutter/material.dart';
import 'package:uService/pages/agency-package/bloc/package_bloc.dart';

Widget inputPackageColor(PackageBloc bloc, TextEditingController controller, Function openColor) {
  return StreamBuilder(
    stream: bloc.colorStream,
    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
      return Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.text,
              enableSuggestions: false,
              autocorrect: false,
              style: TextStyle(color: Colors.black87),
              enabled: false,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1.4,
                        color: Colors.grey[300],
                        style: BorderStyle.solid),
                  ),
                  border: OutlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  errorText: snapshot.error),
              onChanged: bloc.changeColor,
            ),
          ),
          GestureDetector(
            onTap: openColor,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              child: Icon(Icons.color_lens, size: 40, color: Colors.grey),
            ),
          )
        ]);
    },
  );
}