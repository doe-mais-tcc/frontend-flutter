import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

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
          alertBottomSheet(context: context, message: 'Senha incorreta');
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
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            constraints: BoxConstraints(maxWidth: 400),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SvgPicture.asset(
                  'assets/images/logo.svg',
                  width: 60,
                  semanticsLabel: 'Logo Doe mais',
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
        ),
      ),
    );
  }
}
