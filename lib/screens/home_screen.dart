import 'package:contacts_app/screens/add_edit_screen.dart';
import 'package:contacts_app/utils/network.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Network.checkInternet(context);
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (Network.isConnected) {
        Network.getData().then((value) async {
          await Future.delayed(const Duration(seconds: 3));
          setState(() {});
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        onPressed: () {
          AddEditScreen.id = 0;
          AddEditScreen.namecontroller.text = '';
          AddEditScreen.phonecontroller.text = '';
          //
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditScreen(),
            ),
          ).then(
            (value) {
              Network.getData().then(
                (value) async {
                  await Future.delayed(const Duration(seconds: 5));
                  setState(() {});
                },
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.redAccent,
        title: const Text(
          'دفترچه تلفن انلاین',
          style: TextStyle(fontSize: 16),
        ),
        centerTitle: true,
        leading: const Icon(Icons.import_contacts_sharp),
        actions: [
          IconButton(
            onPressed: () {
              Network.checkInternet(context);
              Future.delayed(const Duration(seconds: 3)).then((value) {
                if (Network.isConnected) {
                  Network.getData().then((value) async {
                    await Future.delayed(const Duration(seconds: 3));
                    setState(() {});
                  });
                } else {
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
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: Network.contacts.length,
        itemBuilder: (context, index) {
          return ListTile(
            onLongPress: () async {
              Network.deleteContact(Network.contacts[index].id.toString());
              await Future.delayed(const Duration(seconds: 3));
              setState(() {});
            },
            leading: CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                AddEditScreen.id = Network.contacts[index].id;
                AddEditScreen.namecontroller.text =
                    Network.contacts[index].fullname;
                AddEditScreen.phonecontroller.text =
                    Network.contacts[index].phone;
              },
              icon: const Icon(Icons.edit),
            ),
            title: Text(Network.contacts[index].fullname),
            subtitle: Text(Network.contacts[index].phone),
          );
        },
      ),
    );
  }
}
