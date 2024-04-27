import 'package:flutter/material.dart';
//import 'package:attendence_app/login_page.dart';
import 'user_panel.dart';
//import 'admin_panel.dart';



void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendence_App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: UserPanel(),
    );
  }
}
