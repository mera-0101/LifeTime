import '/global.dart';

class TimerUtils {
  String timerName;
  DateTime timerSetDay;
  DateTime timerGoalDay;

  TimerUtils({
    required this.timerName,
    required this.timerSetDay,
    required this.timerGoalDay,
  });

  TimerUtils.fromJson(Map<String, dynamic> json)
      : timerName = json['timerName'],
        timerSetDay = DateTime.fromMillisecondsSinceEpoch(json['timerSetDay']),
        timerGoalDay = DateTime.fromMillisecondsSinceEpoch(json['timerGoalDay']);

  Map<String, dynamic> toJson() => {
        'timerName': timerName,
        'timerSetDay': timerSetDay.millisecondsSinceEpoch,
        'timerGoalDay': timerGoalDay.millisecondsSinceEpoch,
      };

  static int calculateTotalTimeSeconds(TimerUtils timerUtils) {
    int total = timerUtils.timerGoalDay.difference(timerUtils.timerSetDay).inSeconds;
    return total;
  }

  static int calculateRemainingSeconds(TimerUtils timerUtils) {
    int remainingSeconds = timerUtils.timerGoalDay.difference(DateTime.now()).inSeconds;
    return remainingSeconds >= 0 ? remainingSeconds : 0;
  }

  static String changeFormat(int seconds) {
    switch (Globals.formatTime) {
      case 1:
        return _formatToMinutesAndSeconds(seconds);
      case 2:
        return _formatToHoursMinutesAndSeconds(seconds);
      case 3:
        return _formatToDaysHoursMinutesAndSeconds(seconds);
      default:
        return '$seconds s';
    }
  }

  static String _formatToMinutesAndSeconds(int seconds) {
    int minutes = seconds ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$minutes m $remainingSeconds s';
  }

  static String _formatToHoursMinutesAndSeconds(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$hours h $minutes m $remainingSeconds s';
  }

  static String _formatToDaysHoursMinutesAndSeconds(int seconds) {
    int days = seconds ~/ 86400;
    int hours = (seconds % 86400) ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int remainingSeconds = seconds % 60;
    return '$days d $hours h $minutes m $remainingSeconds s';
  }
}
