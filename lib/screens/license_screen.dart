// ignore_for_file: unrelated_type_equality_checks

import 'dart:convert';
import 'dart:io';

import 'package:contacts_app/screens/home_screen.dart';
import 'package:contacts_app/widget/my_button_widget.dart';
import 'package:contacts_app/widget/my_textfield_widget.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:crypto/crypto.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LicenseScreen extends StatelessWidget {
  LicenseScreen({Key? key}) : super(key: key);

  Future<String?> getDeviceId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor;
    } else {
      var androidDeviceinfo = await deviceInfo.androidInfo;
      return androidDeviceinfo.androidId;
    }
  }

  void showsuccessDialog(BuildContext context) {
    CoolAlert.show(
      width: 100,
      context: context,
      type: CoolAlertType.success,
      title: 'موفق',
      confirmBtnText: 'باشه',
      text: 'کد با موفقیت کپی شد !',
      confirmBtnColor: Colors.redAccent,
      confirmBtnTextStyle: const TextStyle(fontSize: 16, color: Colors.white),
    );
  }

  final TextEditingController systemCodeController = TextEditingController();
  final TextEditingController activeCodeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    getDeviceId().then((value) {
      systemCodeController.text = value ?? '';
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: const Text(
          'فعال سازی',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Clipboard.setData(
                  ClipboardData(text: systemCodeController.text),
                );
                showsuccessDialog(context);
              },
              child: MyTextField(
                isEnabled: false,
                errorText: '',
                controller: systemCodeController,
                hintext: 'کد سیستم',
                type: TextInputType.text,
              ),
            ),
            MyTextField(
              controller: activeCodeController,
              errorText: '',
              hintext: 'کد فعال سازی',
              type: TextInputType.text,
            ),
            const SizedBox(
              height: 20,
            ),
            ButtonWidget(
                onPressed: () async {
                  var bytes1 = utf8.encode(systemCodeController.text);
                  var digest1 = sha512256.convert(bytes1);
                  print(digest1);
                  if (activeCodeController.text == digest1.toString()) {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setBool('isActive', true);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomeScreen(),
                      ),
                    );
                  }
                },
                text: 'فعال سازی'),
          ],
        ),
      ),
    );
  }
}
