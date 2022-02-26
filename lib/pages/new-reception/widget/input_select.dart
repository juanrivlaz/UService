import 'package:flutter/material.dart';
import 'package:uService/models/input_select.dart';

Widget inputSelect({
  @required Stream<int> stream,
  @required Function(int) change,
  @required String label,
  @required List<InputSelect> items
}) {
  return StreamBuilder(
    stream: stream,
    builder: (BuildContext ctx, AsyncSnapshot snp) {
      return DropdownButtonFormField<int>(
        value: snp.hasData ? snp.data : null,
        hint: Text(label),
        onChanged: change,
        isExpanded: true,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 15),
          border: OutlineInputBorder()
        ),
        items: items.map((item) => DropdownMenuItem(
          value: item.value,
          child: Text(item.label)
        )).toList(),
      );
    }
  );
}