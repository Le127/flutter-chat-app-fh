import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  final void Function() onPressed;
  final String text;

  const BotonAzul({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all(2),
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all(StadiumBorder()),
      ),
      onPressed: this.onPressed,
      child: Container(
        width: double.infinity,
        child: Center(
          child: Text(
            this.text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
            ),
          ),
        ),
      ),
    );
  }
}
