import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:my_study_life/providers/theme_notifier.dart';  // Correct import path

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Handle About button tap
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('About'),
                    content: Text('This is a study app to help you manage your tasks, classes, and study time.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: Text('About'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ThemeNotifier themeNotifier = Provider.of<ThemeNotifier>(context, listen: false);
                if (themeNotifier.getTheme() == ThemeData.light()) {
                  themeNotifier.setTheme(ThemeData.dark());
                } else {
                  themeNotifier.setTheme(ThemeData.light());
                }
              },
              child: Text('Toggle Dark Mode'),
            ),
          ],
        ),
      ),
    );
  }
}