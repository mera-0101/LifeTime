// global.dart
import 'package:Tife/utils/timer_utils.dart';

class Globals {
  static int formatTime = 2;
  static bool changeResult = false;
  static String appBarTitle = "";
  static bool isPopupShown = false;
  static TimerUtils newTimer = TimerUtils(
    timerName: "write your goal",
    timerSetDay: DateTime.now(),
    timerGoalDay: DateTime.now(),
  );
}