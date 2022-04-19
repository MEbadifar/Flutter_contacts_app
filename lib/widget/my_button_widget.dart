import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final Function() onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 40.0,
      child: ElevatedButton(
        style: TextButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.redAccent,
        ),
        onPressed: onPressed,
        child: Text(text),
      ),
    );
  }
}
