import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String ruta;
  final String texto;
  final String textoCuenta;

  const Labels(
      {Key? key,
      required this.ruta,
      required this.texto,
      required this.textoCuenta})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            this.texto,
            style: TextStyle(
                color: Colors.black54,
                fontSize: 15,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 10),
          InkWell(
            hoverColor: Colors.transparent,
            child: Text(
              this.textoCuenta,
              style: TextStyle(
                  color: Colors.blue[600],
                  fontSize: 16,
                  fontWeight: FontWeight.bold),
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
          ),
        ],
      ),
    );
  }
}
