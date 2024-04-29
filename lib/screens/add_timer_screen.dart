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
        title: const Text('Add or Edit Timer'),
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
                  Globals.newTimer.timerName = value;
                });
              },
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
