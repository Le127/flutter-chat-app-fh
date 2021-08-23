import 'package:flutter/material.dart';

class BotonAzul extends StatelessWidget {
  //Es dynamic para poder asignarle null a la propiedad onPressed
  final dynamic onPressed;
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
        backgroundColor: this.onPressed == null
            ? MaterialStateProperty.all(Colors.grey)
            : MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all(StadiumBorder()),
        mouseCursor: this.onPressed == null
            ? MaterialStateProperty.all(MouseCursor.defer)
            : MaterialStateProperty.all(MouseCursor.uncontrolled),
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
