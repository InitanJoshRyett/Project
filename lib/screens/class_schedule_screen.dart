import 'package:flutter/material.dart';

class ClassScheduleScreen extends StatefulWidget {
  @override
  _ClassScheduleScreenState createState() => _ClassScheduleScreenState();
}

class _ClassScheduleScreenState extends State<ClassScheduleScreen> {
  List<String> _classSchedules = [];
  
  TextEditingController _scheduleController = TextEditingController();

  void _addClassSchedule() {
    setState(() {
      _classSchedules.add(_scheduleController.text);
      _scheduleController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Class Schedule Maker'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _classSchedules.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_classSchedules[index]),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _scheduleController,
                    decoration: InputDecoration(
                      labelText: 'Enter Class Schedule',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _addClassSchedule();
                  },
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); 
            },
            child: Text('Back to Dashboard'),
          ),
        ],
      ),
    );
  }
}
