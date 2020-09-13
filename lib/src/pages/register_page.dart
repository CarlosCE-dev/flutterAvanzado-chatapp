import 'package:flutter/material.dart';

// Lib
import 'package:provider/provider.dart';

// Helpers
import 'package:chat_app/src/helpers/mostrar_alerta.dart';

// Services
import 'package:chat_app/src/services/socket_service.dart';
import 'package:chat_app/src/services/auth_service.dart';

// Widgets
import 'package:chat_app/src/widgets/label.dart';
import 'package:chat_app/src/widgets/logo.dart';
import 'package:chat_app/src/widgets/custom_input.dart';
import 'package:chat_app/src/widgets/btn_azul.dart';

class RegisterPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2f2f2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(
                  titulo: 'Registro',
                ),
                _Form(),
                Label(
                  route: 'login',
                  primaryText: '¿Ya tienes cuenta?',
                  secodaryText: 'Ingresa con tu cuenta!',
                ),
                Text('Terminos y condiciones de uso', style: TextStyle( fontWeight: FontWeight.w200),)
              ],
            ),
          ),
        ),
      )
   );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);
    final socketService = Provider.of<SocketService>(context);

    return Container(
      margin: EdgeInsets.only( top:40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.account_circle,
            placeholder: 'Nombre',
            keyboardType: TextInputType.text,
            textController: nameCtrl,
          ),
          CustomInput(
            icon: Icons.mail_outline,
            placeholder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock,
            placeholder: 'Contraseña',
            textController: passCtrl,
            isPassword: true,
          ),
          BotonAzul(
            text: 'Registrar',
            onPress: authService.autenticando ? null : () async {
              FocusScope.of(context).unfocus();
              final registroOk = await authService.register(
                nameCtrl.text.trim(),
                emailCtrl.text.trim(), 
                passCtrl.text.trim()
              );

              if ( registroOk == true ){
                socketService.connect();
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(
                  context, 
                  'Registro incorrecto', 
                  registroOk
                );
              }
            },
          )
        ],
      ),
    );
  }
}

