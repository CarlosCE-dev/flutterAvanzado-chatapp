import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services
import 'package:chat_app/src/services/auth_service.dart';

// Helpers
import 'package:chat_app/src/helpers/mostrar_alerta.dart';

// Widgets
import 'package:chat_app/src/widgets/label.dart';
import 'package:chat_app/src/widgets/logo.dart';
import 'package:chat_app/src/widgets/custom_input.dart';
import 'package:chat_app/src/widgets/btn_azul.dart';

class LoginPage extends StatelessWidget {

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
                  titulo: "Mensajes",
                ),
                _Form(),
                Label(
                  route: 'register',
                  primaryText: '¿No tienes cuenta?',
                  secodaryText: 'Crea una ahora!',
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

  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {

    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only( top:40 ),
      padding: EdgeInsets.symmetric( horizontal: 50 ),
      child: Column(
        children: <Widget>[
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
            text: 'Ingrese',
            onPress: authService.autenticando ? null : () async {
              FocusScope.of(context).unfocus();
              final response = await authService.login(emailCtrl.text.trim(), passCtrl.text.trim());
              if ( response ){
                // TODO: Conectar a nuestro socket server
                // TODO: Navegar a otra pantala
                Navigator.pushReplacementNamed(context, 'usuarios');
              } else {
                mostrarAlerta(context, 'Login incorrecto', 'Revise sus credenciales nuevamante');
              }
            },
          )
        ],
      ),
    );
  }
}

