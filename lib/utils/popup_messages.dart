import 'dart:math';

class PopupMessages {
  static final List<String> messages = [
    "there is no rain that does not stop",
    "when are you going to do it? Now!!",
    "the only impossible journey is the one you never begin",
    // 他にもメッセージを追加
  ];

  static String getRandomMessage() {
    final random = Random();
    return messages[random.nextInt(messages.length)];
  }
}
