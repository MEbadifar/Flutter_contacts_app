import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

import '../models/contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Network {
  //! check internet conection

  static bool isConnected = false;

  static Future<bool> checkInternet() async {
    Connectivity().onConnectivityChanged.listen((status) {
      if (status == ConnectivityResult.wifi ||
          status == ConnectivityResult.mobile) {
        isConnected = true;
      } else {
        isConnected = false;
      }
      print(Network.isConnected);
    });
    return isConnected;
  }

  //!show error internet
  static void showInternetError(BuildContext context) {
    CoolAlert.show(
      width: 100,
      context: context,
      type: CoolAlertType.error,
      title: 'خطا',
      text: 'خطا در اتصال',
      confirmBtnText: 'باشه',
      confirmBtnTextStyle: const TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      confirmBtnColor: Colors.redAccent,
    );
  }

  //
  static Uri url = Uri.parse('https://retoolapi.dev/Yw8LBd/contacts');
  //
  static Uri urlWithId(String id) {
    Uri url = Uri.parse('https://retoolapi.dev/Yw8LBd/contacts/$id');
    return url;
  }

  //
  static List<Contact> contacts = [];

  //!Get Data
  static Future<void> getData() async {
    contacts.clear();
    http.get(Network.url).then((response) {
      if (response.statusCode == 200) {
        List jsonDecode = convert.jsonDecode(response.body);
        for (var json in jsonDecode) {
          contacts.add(Contact.fromJson(json));
        }
      }
    });
  }

  //! Post contact
  static void postData({
    required String phone,
    required String fullname,
  }) async {
    Contact contact = Contact(phone: phone, fullname: fullname);
    http.post(Network.url, body: contact.toJson()).then((response) {
      print(response.body);
    });
  }

  //! Put Contact
  static void putData({
    required String phone,
    required String fullname,
    required String id,
  }) async {
    Contact contact = Contact(phone: phone, fullname: fullname);
    http.put(urlWithId(id), body: contact.toJson()).then((response) {
      print(response.body);
    });
  }

  //! Delete Contact
  static void deleteContact(String id) {
    http.delete(Network.urlWithId(id)).then((value) {
      getData(); //refreshed data
    });
  }
}
