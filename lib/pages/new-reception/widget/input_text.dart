import 'package:flutter/material.dart';

Widget inputText({
  @required Stream stream,
  @required Function(String) change,
  @required TextEditingController controller
}) {
  return StreamBuilder(
    stream: stream,
    builder: (BuildContext ctx, AsyncSnapshot snapshot) {
      return TextField(
        controller: controller,
        keyboardType: TextInputType.text,
        enableSuggestions: false,
        autocorrect: false,
        style: TextStyle(color: Colors.black87),
        decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                  width: 1.4,
                  color: Colors.grey[300],
                  style: BorderStyle.solid),
            ),
            border: OutlineInputBorder(),
            contentPadding: EdgeInsets.symmetric(
                vertical: 10, horizontal: 16),
          errorText: snapshot.error
        ),
        onChanged: change,
      );
    }
  );
}