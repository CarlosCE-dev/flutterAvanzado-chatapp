import 'package:http/http.dart' as http;

import 'package:chat_app/src/global/environments.dart';

// Services
import 'package:chat_app/src/services/auth_service.dart';

// Models
import 'package:chat_app/src/models/usuarios_response.dart';
import 'package:chat_app/src/models/usuario.dart';


class UsuarioService {

  Future<List<Usuario>> getUsuarios() async {
      try {
        
        final resp = await http.get('${ Enviroments.apiUrl }/usuarios', 
          headers: {
            'Content-Type': 'application/json',
            'x-token': await AuthService.getToken()
          }
        );

        final usuariosResponse = usuariosResponseFromJson( resp.body );
        return usuariosResponse.data;

      } catch (e) {
        return [];
      }
  }

}