import 'package:flutter/material.dart';
import 'add_reminder_screen.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);
  @override
  _ReminderScreenState createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  List<Map<String, dynamic>> reminders = [
    {"title": "It's Work Out Time!", "time": "10:00 AM WIB", "isActive": true},
    {"title": "Lunch Time", "time": "12:00 PM WIB", "isActive": true},
    {"title": "Sleep", "time": "10:00 PM WIB", "isActive": false},
    {"title": "Sunlight and Fresh Air", "time": "08:00 AM WIB", "isActive": true},
    {"title": "Don't skip a healthy dinner!", "time": "07:00 PM WIB", "isActive": false},
  ];

  void _navigateToAddReminderPage(BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddReminderScreen()),
    );
    if (result != null) {
      setState(() {
        reminders.add(result);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final customColor = Color(0xFF00D9C0);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white, 
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Reminder',
          style: TextStyle(
            color: Color(0xFF00D9C0),
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: null,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(2),
          child: Container(
            height: 2,
            color: Colors.grey[300],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 80),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: reminders.length,
                itemBuilder: (context, index) {
                  final reminder = reminders[index];
                  return Dismissible(
                    key: Key(reminder['title']!),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      setState(() {
                        reminders.removeAt(index);
                      });
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("${reminder['title']} deleted")),
                      );
                    },
                    background: Container(
                      color: Colors.red,
                      child: const Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Delete',
                            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      title: Text(
                        reminder['title']!,
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      subtitle: Text("Every day at ${reminder['time']}"),
                      trailing: Switch(
                        value: reminder['isActive'],
                        onChanged: (bool value) {
                          setState(() {
                            reminder['isActive'] = value;
                          });
                        },
                        activeColor: customColor,
                        inactiveThumbColor: Colors.grey,
                        inactiveTrackColor: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: SafeArea(
        child: FloatingActionButton(
          onPressed: () => _navigateToAddReminderPage(context),
          backgroundColor: customColor,
          child: Icon(Icons.add, color: Colors.white),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
