import 'package:flutter/material.dart';
import '../utils/popup_messages.dart';

class PopupWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("todays words"),
      content: Text(PopupMessages.getRandomMessage()),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // ポップアップを閉じる
          },
          child: const Text("OK"),
        ),
      ],
    );
  }
}
