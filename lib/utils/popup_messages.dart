import 'dart:math';

class PopupMessages {
  static final List<String> messages = [
    "メッセージ1",
    "メッセージ2",
    "メッセージ3",
    // 他にもメッセージを追加
  ];

  static String getRandomMessage() {
    final random = Random();
    return messages[random.nextInt(messages.length)];
  }
}
