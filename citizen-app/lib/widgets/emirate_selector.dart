import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmirateSelector extends StatefulWidget {
  final Function(String) onEmirateChanged;
  const EmirateSelector({super.key, required this.onEmirateChanged});

  @override
  State<EmirateSelector> createState() => _EmirateSelectorState();
}

class _EmirateSelectorState extends State<EmirateSelector> {
  String _selectedEmirate = 'Dubai';
  final List<String> _emirates = [
    'Abu Dhabi', 'Dubai', 'Sharjah', 'Ajman',
    'Umm Al Quwain', 'Ras Al Khaimah', 'Fujairah',
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedEmirate();
  }

  _loadSavedEmirate() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _selectedEmirate = prefs.getString('emirate') ?? 'Dubai';
    });
    widget.onEmirateChanged(_selectedEmirate);
  }

  _saveEmirate(String emirate) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('emirate', emirate);
    setState(() => _selectedEmirate = emirate);
    widget.onEmirateChanged(emirate);
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: _selectedEmirate,
      icon: const Icon(Icons.arrow_drop_down),
      underline: const SizedBox(),
      onChanged: (String? newValue) {
        if (newValue != null) _saveEmirate(newValue);
      },
      items: _emirates.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
