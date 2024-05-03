import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '/utils/timer_utils.dart';
import '/global.dart';
import 'settings_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/popup_widget.dart';
import 'add_timer_screen.dart';
import 'dart:convert';

class TimerScreen extends StatefulWidget {
  const TimerScreen({Key? key}) : super(key: key);

  @override
  TimerScreenState createState() => TimerScreenState();
}

class TimerScreenState extends State<TimerScreen> with TickerProviderStateMixin {
  late Timer _timer;
  late AnimationController _animationController;
  double _wavePhase = 0.0;
  List<TimerUtils> timerList = [];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..addListener(() {
        setState(() {
          _wavePhase = _animationController.value * 2 * math.pi;
        });
      });
    _animationController.repeat();
    _initState();
  }

  Future<void> _initState() async {
    await _loadTimerData();
  }

  Future<void> _loadTimerData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> timerListJson = prefs.getStringList('timerListJson') ?? [];
    setState(() {
      Globals.appBarTitle = prefs.getString('appBarTitle') ?? 'Life Timer';
      Globals.formatTime = prefs.getInt('formatTime') ?? 2;
      Globals.isPopupShown = false;
      timerList = timerListJson.map((f) => TimerUtils.fromJson(json.decode(f))).toList();
    });
    _saveTimerData();
  }

  void _saveTimerData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> timerListJson = timerList.map((f) => json.encode(f.toJson())).toList();
    prefs.setStringList('timerListJson', timerListJson);
  }

  @override
  void dispose() {
    _timer.cancel();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showPopup();
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(
          Globals.appBarTitle,
          style: const TextStyle(
              color: Color.fromARGB(255, 219, 219, 219), // テキストの色を白色に設定
            ),
          ),
        
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.black, // アイコンの色を赤色に設定
            ),
            onPressed: () => _openSettingsScreen(context),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: timerList.length,
            itemBuilder: (context, index) {
              return Card(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (_, __) => CustomPaint(
                          painter: WaterWavePainter(
                            wavePhase: _wavePhase + index * 0.2,
                            waterHeightRatio: TimerUtils.calculateRemainingSeconds(timerList[index]) / TimerUtils.calculateTotalTimeSeconds(timerList[index]),
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      leading: SizedBox(
                        width: MediaQuery.of(context).size.width / 5, // 画面の4分の1の幅に設定
                        child: Text(
                          timerList[index].timerName,
                          style: const TextStyle(fontSize: 12),
                          overflow: TextOverflow.clip, // テキストが四角形の外側にはみ出す場合、クリップする
                        ),
                      ),
                      title: Text(
                        TimerUtils.changeFormat(TimerUtils.calculateRemainingSeconds(timerList[index])),
                        style: const TextStyle(fontSize: 13),
                        textAlign: TextAlign.center, // 中央寄せに設定
                      ),
                      trailing: Row(
                        mainAxisAlignment: MainAxisAlignment.end, // 右寄せ
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit),
                            onPressed: () async {
                              bool isEdited = await Navigator.of(context).push(
                                MaterialPageRoute(builder: (context) {
                                  return AddTimerScreen(timer: timerList[index]);
                                }),
                              );
                              if(isEdited){
                                setState(() {
                                  timerList[index] = Globals.newTimer;
                                  _saveTimerData();
                                });
                              }
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              setState(() {
                                timerList.removeAt(index);
                                _saveTimerData();
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final bool isSetNewTimer = await Navigator.of(context).push(
            MaterialPageRoute(builder: (context) {
              TimerUtils newTimer = TimerUtils(timerName: "", timerSetDay: DateTime.now(), timerGoalDay: DateTime.now());
              return AddTimerScreen(timer: newTimer);
            }),
          );
          if(isSetNewTimer){
            setState(() {
              timerList.add(Globals.newTimer);
              _saveTimerData();
            });
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openSettingsScreen(BuildContext context) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen())
    );

    if (Globals.changeResult) {
      setState(() {
        Globals.changeResult = false;
      });
    }
  }

  void _showPopup() {
    if (!Globals.isPopupShown) {
      Globals.isPopupShown = true;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return  const PopupWidget();
        },
      );
    }
  }
}

class WaterWavePainter extends CustomPainter {
  final double wavePhase;
  final double waterHeightRatio;

  WaterWavePainter({required this.wavePhase, required this.waterHeightRatio});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black26;
    final path = Path();

    const waveAmplitude = 5.0;
    final waterTop = size.width * waterHeightRatio;

    path.moveTo(waterTop, 0);
    for (double y = 0.0; y <= size.height; y++) {
      final x = waterTop + math.sin(wavePhase + y * 0.06) * waveAmplitude;
      path.lineTo(x, y);
    }

    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
