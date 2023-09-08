import 'package:flutter/material.dart';
import 'package:gst_calc/screen/gst_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GST Calculator',
      home: GST_Screen(),
    );
  }
}
