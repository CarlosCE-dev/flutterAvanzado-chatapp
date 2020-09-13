import 'package:chat_app/src/models/mensajes_response.dart';
import 'package:flutter/material.dart';

// Lib
import 'package:http/http.dart' as http;

// Services
import 'package:chat_app/src/services/auth_service.dart';

// Environments
import 'package:chat_app/src/global/environments.dart';

// Models
import 'package:chat_app/src/models/usuario.dart';

class ChatService with ChangeNotifier {

  Usuario usuarioPara;

  Future<List<Mensaje>> getChat( String usuarioId ) async {
    try {
        
      final resp = await http.get('${ Enviroments.apiUrl }/mensajes/$usuarioId', 
        headers: {
          'Content-Type': 'application/json',
          'x-token': await AuthService.getToken()
        }
      );

      final mensajesResponse = mensajesResponseFromJson( resp.body );
      return mensajesResponse.data;

    } catch (e) {
      return [];
    }
  }

}