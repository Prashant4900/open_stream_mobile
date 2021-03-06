import 'package:flutter/material.dart';

void displayDialog({context, title = "An Error Occurred", text}) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(text),
      ),
    );
