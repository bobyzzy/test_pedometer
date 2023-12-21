import 'package:flutter/material.dart';
import 'package:pedometer_app/screens/home_screen.dart';
import 'package:permission_handler/permission_handler.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Permission.activityRecognition.request();
  await Permission.location.request();
  runApp(const PedometerApp());
}

class PedometerApp extends StatelessWidget {
  const PedometerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.grey.shade200,
        appBarTheme: AppBarTheme(backgroundColor: Colors.grey.shade200),
      ),
      home: const HomeScreen(),
    );
  }
}
