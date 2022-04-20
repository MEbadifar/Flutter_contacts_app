import 'package:contacts_app/widget/my_button_widget.dart';
import 'package:contacts_app/widget/my_textfield_widget.dart';
import 'package:flutter/material.dart';

import '../utils/network.dart';

class AddEditScreen extends StatefulWidget {
  static TextEditingController namecontroller = TextEditingController();
  static TextEditingController phonecontroller = TextEditingController();
  static int id = 0;
  const AddEditScreen({Key? key}) : super(key: key);

  @override
  State<AddEditScreen> createState() => _AddEditScreenState();
}

class _AddEditScreenState extends State<AddEditScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.redAccent,
          title: Text(
            AddEditScreen.id == 0 ? 'ویرایش مخاطب' : 'مخاطب جدید',
            style: const TextStyle(fontSize: 16),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              MyTextField(
                controller: AddEditScreen.namecontroller,
                hintext: 'نام',
                errorText: 'لطفا نام را وارد کنید',
                type: TextInputType.name,
              ),
              MyTextField(
                controller: AddEditScreen.phonecontroller,
                hintext: 'شماره',
                errorText: 'لطفا شماره را وارد کنید',
                type: TextInputType.number,
              ),
              const SizedBox(height: 20.0),
              ButtonWidget(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    //
                    Network.checkInternet();
                    Future.delayed(const Duration(seconds: 3)).then(
                      (value) {
                        if (Network.isConnected) {
                          if (AddEditScreen.id == 0) {
                            Network.postData(
                              phone: AddEditScreen.phonecontroller.text,
                              fullname: AddEditScreen.namecontroller.text,
                            );
                          } else {
                            Network.putData(
                              phone: AddEditScreen.phonecontroller.text,
                              fullname: AddEditScreen.namecontroller.text,
                              id: AddEditScreen.id.toString(),
                            );
                          }
                          Navigator.pop(context);
                        } else {
                          Network.showInternetError(context);
                        }
                      },
                    );

                    //

                    // Network.deleteContact('2');

                    //

                    //Network.putData(
                    //id:'1';
                    //    phone: AddEditScreen.phonecontroller.text,
                    //  fullname: AddEditScreen.namecontroller.text);

                  }
                },
                text: AddEditScreen.id == 0 ? 'ویرایش کردن' : 'اضافه کردن',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
