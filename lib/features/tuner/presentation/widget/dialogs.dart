import 'package:flutter/material.dart';

void buildDialog(BuildContext context, Widget content) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        content: content,
        actions: <Widget>[
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
