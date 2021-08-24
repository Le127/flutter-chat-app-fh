import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chat_app/models/login_response.dart';
import 'package:chat_app/global/enviroment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  late SharedPreferences _preferences;
  final String _tokenKey = 'token';

  bool get autenticando => this._autenticando;

  set autenticando(bool valor) {
    this._autenticando = valor;
    notifyListeners();
  }

  Future<SharedPreferences> _initialPreferences() async =>
      _preferences = await SharedPreferences.getInstance();

//Getters del token de forma estática
  static Future getToken() async {
    late SharedPreferences _preferences;

    Future<SharedPreferences> _initialPreferences() async =>
        _preferences = await SharedPreferences.getInstance();

    await _initialPreferences();
    final token = _preferences.getString('token');
    return token;
  }

  static Future<void> deleteToken() async {
    late SharedPreferences _preferences;

    Future<SharedPreferences> _initialPreferences() async =>
        _preferences = await SharedPreferences.getInstance();

    await _initialPreferences();

    _preferences.remove('token');
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

      // guardar token en lugar seguro
      await _guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }
  }

  Future _guardarToken(String token) async {
    await _initialPreferences();
    return _preferences.setString(_tokenKey, token);
  }

  Future<void> logout() async {
    await _initialPreferences();
    await _preferences.clear();
  }
}
