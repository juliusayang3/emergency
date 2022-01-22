import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog({
    Key key,
    this.title,
    this.content,
    this.onPressed,
  }) : super(key: key);

  final String title;
  final String content;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: onPressed,
          child: Text(
            'OK',
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            'OK',
          ),
        ),
      ],
    );
  }
}
