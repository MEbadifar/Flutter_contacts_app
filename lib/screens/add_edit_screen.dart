import 'package:contacts_app/widget/my_button_widget.dart';
import 'package:contacts_app/widget/my_textfield_widget.dart';
import 'package:flutter/material.dart';

class AddEditScreen extends StatefulWidget {
  static TextEditingController namecontroller = TextEditingController();
  static TextEditingController phonecontroller = TextEditingController();

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
          title: const Text(
            'مخاطب جدید',
            style: TextStyle(fontSize: 16),
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
                    print('ok');
                  }
                },
                text: 'اضافه کردن',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
