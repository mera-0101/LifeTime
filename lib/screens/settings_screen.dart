import 'package:flutter/material.dart';
import '/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  SettingsScreenState createState() => SettingsScreenState();
}

class SettingsScreenState extends State<SettingsScreen> {
  late TextEditingController _titleController;
  int _selectedFormat = Globals.formatTime;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: Globals.appBarTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style:  TextStyle(
            color: Color.fromARGB(255, 219, 219, 219), // テキストの色を白色に設定
          ),),
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(5.0)),
            _buildAppSettingsSection(),
            const Padding(padding: EdgeInsets.all(5.0)),
            _buildTimeFormatSection(),
            const SizedBox(height: 32),
            _buildSaveButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppSettingsSection() {
    return _buildSectionCard(
      title: 'App Settings',
      children: [
        _buildTextInputField(_titleController, 'Title', 'Enter Your Goal', Icons.text_fields),
      ],
    );
  }

  Widget _buildTimeFormatSection() {
    return _buildSectionCard(
      title: 'Time Format',
      children: List.generate(4, (index) => _buildTimeFormatOption(index)),
    );
  }

  Widget _buildSectionCard({required String title, required List<Widget> children}) {
    return Card(
      color: Colors.grey[150],
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          const Divider(),
          ...children,
        ]),
      ),
    );
  }

  Widget _buildTextInputField(TextEditingController controller, String label, String hint, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label, hintText: hint, icon: Icon(icon)),
    );
  }

  Widget _buildTimeFormatOption(int value) {
    List<String> titles = ['0s', '0m 0s', '0h 0m 0s', '0d 0h 0m 0s'];
    return RadioListTile<int>(
      title: Text(titles[value]),
      value: value,
      groupValue: _selectedFormat,
      onChanged: (newValue) => setState(() => _selectedFormat = newValue!),
    );
  }

  Widget _buildSaveButton() {
    return ElevatedButton(
      onPressed: _saveSettingsAndClose,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.grey[700],
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20.0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      child: const Text('Save', style: TextStyle(color: Color.fromARGB(255, 219, 219, 219),fontSize: 18, fontWeight: FontWeight.bold)),
    );
  }


  void _saveSettingsAndClose() async {
    _saveSettings();
    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings saved successfully!')));
  }

  void _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('appBarTitle', _titleController.text);
    prefs.setInt('formatTime', _selectedFormat);
    Globals.appBarTitle = _titleController.text;
    Globals.formatTime = _selectedFormat;
    Globals.changeResult = true;
    Globals.isPopupShown = true;
  }
}
