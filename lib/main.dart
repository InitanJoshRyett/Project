import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_study_life/screens/welcome_screen.dart';
import 'package:my_study_life/screens/login_screen.dart';
import 'package:my_study_life/screens/dashboard_screen.dart';
import 'package:my_study_life/screens/class_schedule_screen.dart';
import 'package:my_study_life/screens/study_timer_screen.dart';
import 'package:my_study_life/screens/task_manager_screen.dart';
import 'package:my_study_life/providers/theme_notifier.dart';  

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(
    ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(ThemeData.light()),
      child: MyApp(),
    ),
  );
}

class DefaultFirebaseOptions {
  static var currentPlatform;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);

    return MaterialApp(
      title: 'My Study Life',
      theme: themeNotifier.getTheme(),
      initialRoute: '/welcome',
      routes: {
        '/welcome': (context) => WelcomeScreen(),
        '/login': (context) => LoginScreen(),
        '/dashboard': (context) => DashboardScreen(),
        '/class_schedule': (context) => ClassScheduleScreen(),
        '/study_timer': (context) => StudyTimerScreen(),
        '/task_manager': (context) => TaskManagerScreen(),
      },
    );
  }
}
