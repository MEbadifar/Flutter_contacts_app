import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:contacts_app/screens/home_screen.dart';
import 'package:contacts_app/utils/network.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Network.checkInternet();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Network.getData();
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'دفترچه تلفن انلاین',
      //theme: ThemeData(fontFamily: ''),
      home: HomeScreen(),
    );
  }
}
