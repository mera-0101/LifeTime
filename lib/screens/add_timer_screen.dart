import 'package:flutter/material.dart';
import '../utils/timer_utils.dart';
import '/global.dart';
import 'package:intl/intl.dart';

class AddTimerScreen extends StatefulWidget {
  final TimerUtils timer;
  const AddTimerScreen({Key? key, required this.timer}) : super(key: key);

  @override
  AddTimerScreenState createState() => AddTimerScreenState();
}

class AddTimerScreenState extends State<AddTimerScreen> {
  bool isSetTimer = false;
  late TextEditingController _timerNameController;

  @override
  void initState() {
    super.initState();
    Globals.newTimer = widget.timer;
    _timerNameController = TextEditingController(text: Globals.newTimer.timerName);
  }

  @override
  void dispose() {
    _timerNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add or Edit Timer',
          style: TextStyle(
            color: Colors.white, // テキストの色を白色に設定
          ),),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              Globals.newTimer.timerName,
              style: const TextStyle(color: Colors.blue),
            ),
            const SizedBox(height: 8),

            TextField(
              controller: _timerNameController,
              onChanged: (String value) {
                setState(() {
                  final String sanitizedValue = value.replaceAll(RegExp(r'[0-9]'), ''); // 数字を削除して、残った文字列の長さを取得
                  final int totalLength = sanitizedValue.length * 3 + (value.length - sanitizedValue.length) * 4; // 文字の場合は3文字、数字の場合は4文字としてカウント
                  if (totalLength <= 72) {
                    Globals.newTimer.timerName = value;
                  } else {
                    // 72文字を超える場合は、メッセージを表示
                    // _timerNameController.text = _timerNameController.text.substring(0, 72);
                    // カーソル位置を最後尾に移動する
                    _timerNameController.selection = TextSelection.fromPosition(
                      TextPosition(offset: _timerNameController.text.length),
                    );
                    // または、以下のようにすることで、入力を受け付けないようにもできます
                    // _timerNameController.text = '';
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('character count over'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                });
              },
              // maxLength:ljk 72, // 総文字数制限
              // buildCounter: (BuildContext context,
              //     {required int currentLength, required bool isFocused, required int? maxLength}) {
              //   final String sanitizedValue = _timerNameController.text.replaceAll(RegExp(r'[0-9]'), '');
              //   final int totalLength = sanitizedValue.length * 3+ (_timerNameController.text.length - sanitizedValue.length) * 4;
              //   return Text(
              //     '$totalLength / $maxLength',
              //     style: TextStyle(color: isFocused ? Colors.red : null),
              //   );
              // },
            ),

            const SizedBox(height: 8),
            _buildGoalDateTile(),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  isSetTimer = true;
                  Navigator.of(context).pop(isSetTimer);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 78, 78, 78), // ボタンの背景色を灰色に設定
                ),
                child: const Text('Add or Edit Timer', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop(isSetTimer);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 255, 255), // ボタンの背景色を灰色に設定
                ),
                child: const Text('Cancel'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalDateTile() {
    return ListTile(
      leading: const Icon(Icons.calendar_today),
      title: Text(DateFormat('yyyy-MM-dd').format(Globals.newTimer.timerGoalDay)),
      onTap: () => _selectEventDate(context),
    );
  }

  Future<void> _selectEventDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: Globals.newTimer.timerSetDay,
      firstDate: DateTime.now(),
      lastDate: DateTime(2200),
    );
    if (picked != null && picked != Globals.newTimer.timerGoalDay) {
      setState(() {
        Globals.newTimer.timerGoalDay = picked;
        Globals.newTimer.timerSetDay = DateTime.now();
      });
    }
  }
}
