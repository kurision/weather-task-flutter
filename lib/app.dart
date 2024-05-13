import 'package:flutter/material.dart';
import 'package:weather_task/features/splash/help_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather Task',
      theme: ThemeData.dark(),
      home: const HelpScreen(),
    );
  }
}
