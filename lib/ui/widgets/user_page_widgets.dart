import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyColumn extends StatelessWidget {
  const MyColumn({
    Key key,
    @required String label,
    @required String title,
  })  : _label = label,
        _title = title,
        super(key: key);

  final String _label;
  final String _title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          _label,
          style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.w500),
        ),
        Text(
          _title ?? ' ',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ],
    );
  }
}
