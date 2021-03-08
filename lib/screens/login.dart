import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

class Login extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();

  void validateForm() {
    if (!_formKey.currentState.validate()) return;

    //TO-DO: enviar login para o banco
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/logo.svg',
                  semanticsLabel: 'Logo Doe mais',
                ),
                Text('Bem Vindo(a)'),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration:
                            InputDecoration(labelText: 'Insira seu email'),
                        validator: (data) =>
                            data.isEmpty ? 'Obrigatório' : null,
                      ),
                      TextFormField(
                        controller: _pwdController,
                        obscureText: true,
                        decoration:
                            InputDecoration(labelText: 'Insira sua senha'),
                        validator: (data) =>
                            data.isEmpty ? 'Obrigatório' : null,
                      ),
                    ],
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/signup'),
                  child: Text('Não tem conta? Cadastre-se'),
                ),
                TextButton(
                  onPressed: null,
                  child: Text('Esqueceu sua senha?'),
                ),
                SizedBox(height: 20),
                CustomElevatedButton(
                  label: 'Entrar',
                  onPressed: validateForm,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
