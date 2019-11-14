import 'package:flutter/material.dart';
import 'package:notifications_admin/network/networkManagerImpl.dart';
import 'package:notifications_admin/pages/notifications_admin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Notifications Admin',
      theme: ThemeData(
        primarySwatch: white,
      ),
      home: AdminHome(networkManager: NetworkManagerImpl(),),
    );
  }

  static const MaterialColor white = MaterialColor(
    _whitePrimaryValue,
    <int, Color>{
      50: Color(0xFFECEFF1),
      100: Color(0xFFCFD8DC),
      200: Color(0xFFB0BEC5),
      300: Color(0xFF90A4AE),
      400: Color(0xFF78909C),
      500: Color(0xFF607D8B),
      600: Color(0xFF546E7A),
      700: Color(0xFF455A64),
      800: Color(0xFF37474F),
      900: Color(0xFF263238),
    },
  );
  static const int _whitePrimaryValue = 0xFFFFFFFF;
}
