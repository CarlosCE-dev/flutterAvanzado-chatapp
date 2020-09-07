import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Environments
import 'package:chat_app/src/global/environments.dart';
import 'package:chat_app/src/models/usuario.dart';

// Models
import 'package:chat_app/src/models/login_response.dart';

class AuthService with ChangeNotifier {

  Usuario usuario;
  bool _autenticando = false;

  final _storage = FlutterSecureStorage();

  bool get autenticando => this._autenticando;
  set autenticando( bool valor ){
    this._autenticando = valor;
    notifyListeners();
  }

  // Getter del token de forma estatica
  static Future<String> getToken() async {
    final _storage = new FlutterSecureStorage(); 
    final token = await _storage.read(key: 'token');
    return token;
  }

  // Getter del token de forma estatica
  static Future<void> deleteToken() async {
    final _storage = new FlutterSecureStorage(); 
    await _storage.delete(key: 'token');
  }

  Future<bool> login( String email, String password ) async {

    this.autenticando = true;

    final payload = {
      'email': email,
      'password': password
    };

    final resp = await http.post('${ Enviroments.apiUrl }/login', 
      body: jsonEncode(payload),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if ( resp.statusCode == 200){
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario = loginResponse.data;
      
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      return false;
    }

  }

  Future register( String nombre, String email, String password ) async {
    this.autenticando = true;

    final payload = {
      'nombre' : nombre, 
      'email': email,
      'password': password,
    };

    final resp = await http.post('${ Enviroments.apiUrl }/login/new', 
      body: jsonEncode(payload),
      headers: {
        'Content-Type': 'application/json'
      }
    );

    this.autenticando = false;

    if ( resp.statusCode == 200){
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario = loginResponse.data;
      
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await this._storage.read(key: 'token');
    
    final resp = await http.get('${ Enviroments.apiUrl }/login/renew', 
      headers: {
        'Content-Type': 'application/json',
        'x-token': token
      }
    );

    if ( resp.statusCode == 200){
      final loginResponse = loginResponseFromJson( resp.body );
      this.usuario = loginResponse.data;
      
      await this._guardarToken(loginResponse.token);

      return true;
    } else {
      this._eliminarToken();
      return false;
    }
  }

  Future _guardarToken( String token ) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _eliminarToken() async {
    await _storage.delete(key: 'token');
  }

}