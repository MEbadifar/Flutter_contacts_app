import 'dart:io';
import 'dart:ui';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contacts_app/screens/home_screen.dart';
import 'package:contacts_app/screens/license_screen.dart';
import 'package:contacts_app/utils/network.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

Future<bool> isActive() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getBool('isActive') ?? false;
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    Network.checkInternet(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'دفترچه تلفن انلاین',
      //theme: ThemeData(fontFamily: ''),
      home: FutureBuilder(
          future: isActive(),
          builder: (context, snapshot) {
            if (snapshot.data == true) {
              return const HomeScreen();
            } else {
              return LicenseScreen();
            }
          }),
    );
  }
}
