import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/global/enviroment.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;

  bool _autenticando = false;

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  //Autenticacion del Login
  Future<bool> login(String email, String password) async {
    this.autenticando = true;

    final data = {
      "email": email,
      "password": password,
    };

    final uri = Uri.parse("${Enviroment.apiUrl}/login");

    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    print(resp.body);
    this.autenticando = false;

    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;

      //ToDo: guardar token en lugar seguro

      return true;
    } else {
      return false;
    }
  }
}
