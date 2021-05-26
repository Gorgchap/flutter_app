import 'package:flutter/material.dart';

@immutable
class Popup extends StatelessWidget {
  final String title;
  final String content;
  Popup({
    required this.title,
    required this.content
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.black54,
        child: AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('ОК'),
            ),
          ],
        )
    );
  }
}