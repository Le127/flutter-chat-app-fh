import 'package:chat_app/helpers/mostrar_alerta.dart';
import 'package:chat_app/services/auth_service.dart';
import 'package:chat_app/widgets/boton_azul.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/custom_labels.dart';
import 'package:chat_app/widgets/custom_logo.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Logo(
                  titulo: "Registro",
                ),
                _Form(),
                Labels(
                  ruta: "login",
                  texto: "¿Ya tienes cuenta?",
                  textoCuenta: "Ingresa",
                ),
                Text("Términos y condiciones de uso",
                    style: TextStyle(fontWeight: FontWeight.w200)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Container(
      margin: EdgeInsets.only(top: 40),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: "Nombre",
            textController: nameController,
          ),
          CustomInput(
            icon: Icons.perm_identity,
            placeholder: "Correo",
            keyboardType: TextInputType.emailAddress,
            textController: emailController,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeholder: "Contraseña",
            textController: passwordController,
            isPassword: true,
          ),
          BotonAzul(
            text: "Ingrese",
            onPressed: authService.autenticando
                ? null
                : () async {
                    //Para cerrar el teclado luego de presionar en Ingrese
                    FocusScope.of(context).unfocus();

                    final registerOk = await authService.register(
                        nameController.text.trim(),
                        emailController.text.trim(),
                        passwordController.text);

                    if (registerOk == true) {
                      //TodO: conectar al socket server

                      //Navegar a otra pantalla
                      Navigator.pushReplacementNamed(context, 'usuarios');
                    } else {
                      mostrarAlerta(
                          context,
                          "Registro incorrecto",
                          registerOk == null
                              ? "Complete los campos"
                              : registerOk);
                    }
                  },
          ),
        ],
      ),
    );
  }
}
