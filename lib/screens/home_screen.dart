import 'package:contacts_app/screens/add_edit_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.redAccent,
        elevation: 0,
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
            onPressed: () {},
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.redAccent,
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            trailing: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.edit),
            ),
            title: const Text('salam'),
            subtitle: const Text('0152'),
          );
        },
      ),
    );
  }
}
