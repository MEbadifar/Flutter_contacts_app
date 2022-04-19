import 'package:contacts_app/screens/home_screen.dart';
import 'package:contacts_app/utils/network.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
