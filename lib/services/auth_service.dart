import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/global/enviroment.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;

  bool _atenticando = false;

  bool get autenticando => this._atenticando;

  set autenticando(bool valor) {
    this._atenticando = valor;
    notifyListeners();
  }

  //Autenticacion del Login
  Future login(String email, String password) async {
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
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromJson(resp.body);
      this.usuario = loginResponse.usuario;
    }

    this.autenticando = false;
  }
}
