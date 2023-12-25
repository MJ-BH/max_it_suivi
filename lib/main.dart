import 'package:Suivi_Max_It/pages/welcom_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: SafeArea(child: WelcomScreen())));
  }
}
