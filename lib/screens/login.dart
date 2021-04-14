import 'package:doe_mais/components/custom_back_button.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  bool _saveSession = false;

  void validateForm(BuildContext context) {
    if (!_formKey.currentState.validate()) return;

    User user = User(
      email: _emailController.text,
      senha: _pwdController.text,
    );
    UserDao.checkUser(user).then(
      (result) {
        if (result != null) {
          if (_saveSession)
            SessionManager.saveSession(result);
          else
            SessionManager.currentUser = result;
          Navigator.of(context).pushReplacementNamed('/home');
        } else
          alertBottomSheet(
            context: context,
            message: 'Senha incorreta',
            timeLimit: 5,
          );
      },
    ).onError((error, stackTrace) {
      alertBottomSheet(
          context: context, message: 'Não foi possível realizar o login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 80, left: 80, top: 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: CustomBackButton(),
            ),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 400),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 80,
                  ),
                  Text('Bem Vindo(a)',
                      style: Theme.of(context).textTheme.headline1),
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          autofillHints: [AutofillHints.username],
                          decoration:
                              InputDecoration(labelText: 'Insira seu email'),
                          validator: (data) =>
                              data.isEmpty ? 'Obrigatório' : null,
                        ),
                        TextFormField(
                          controller: _pwdController,
                          obscureText: true,
                          autofillHints: [AutofillHints.password],
                          decoration:
                              InputDecoration(labelText: 'Insira sua senha'),
                          validator: (data) =>
                              data.isEmpty ? 'Obrigatório' : null,
                        ),
                      ],
                    ),
                  ),
                  CheckboxListTile(
                    controlAffinity: ListTileControlAffinity.leading,
                    title: Text('Me manter conectado'),
                    value: _saveSession,
                    onChanged: (value) => setState(() => _saveSession = value),
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
                    onPressed: () => validateForm(context),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
