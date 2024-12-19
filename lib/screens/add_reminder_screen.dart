import 'package:flutter/material.dart';

class AddReminderScreen extends StatefulWidget {
  @override
  _AddReminderScreenState createState() => _AddReminderScreenState();
}

class _AddReminderScreenState extends State<AddReminderScreen> {
  final _titleController = TextEditingController();
  final bool _isActive = true;
  final _formKey = GlobalKey<FormState>();
  String _timeText = "Select Time";

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (picked != null && picked != TimeOfDay.now()) {
      setState(() {
        _timeText = picked.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, 
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Add New Reminder',
          style: TextStyle(
            color: Color(0xFF00D9C0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            color: Colors.grey[300],
            height: 2,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Reminder Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: TextEditingController(text: _timeText),
                    decoration: InputDecoration(labelText: 'Reminder Time'),
                    validator: (value) {
                      if (value == null ||
                          value.isEmpty ||
                          value == "Select Time") {
                        return 'Please select a time';
                      }
                      return null;
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final reminder = {
                      'title': _titleController.text,
                      'time': _timeText,
                      'isActive': _isActive,
                    };
                    Navigator.pop(context, reminder);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF00D9C0),
                  foregroundColor: Colors.white,
                ),
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
