import '../models/contact.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Network {
  static Uri url = Uri.parse('https://retoolapi.dev/Yw8LBd/contacts');
  //
  static List<Contact> contacts = [];

  //!Get Data
  static void getData() async {
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
}
