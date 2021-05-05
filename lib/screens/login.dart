import 'package:doe_mais/components/custom_back_button.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:password_credential/credentials.dart';
import 'package:password_credential/entity/mediation.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwdController = TextEditingController();
  bool _saveSession = false;

  void validateForm(BuildContext context) async {
    if (!_formKey.currentState.validate()) return;

    User user = User(
      email: _emailController.text,
      senha: _pwdController.text,
    );
    //Returns user on success and null on fail
    var returnedUser = await UserDao.checkUser(user)
        //For internet error or no match user
        .onError(
      (error, stackTrace) {
        alertBottomSheet(
            context: context, message: 'Não foi possível realizar o login');
        return;
      },
    );
    if (returnedUser == null) {
      alertBottomSheet(
        context: context,
        message: 'Email ou senha incorretos',
        timeLimit: 5,
      );
      return;
    }

    //Requests user to save credentials
    Credentials().store(
      _emailController.text,
      _pwdController.text,
      Mediation.Optional,
    );
    //Saves session if required, otherwise just sets temp user
    if (_saveSession)
      SessionManager.saveSession(returnedUser);
    else
      SessionManager.currentUser = returnedUser;

    //Return home
    Navigator.of(context).pushReplacementNamed('/inicio');
  }

  void _getCredentials() async {
    var credentials = await Credentials().get(Mediation.Optional);
    if (credentials == null) return;
    _emailController.text = credentials.name;
    _pwdController.text = credentials.password;
  }

  @override
  void initState() {
    super.initState();
    _getCredentials();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomBackButton(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                padding:
                    const EdgeInsets.only(left: 50, right: 50, bottom: 100),
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
                      onChanged: (value) =>
                          setState(() => _saveSession = value),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.of(context).pushNamed('/signup'),
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
          ],
        ),
      ),
    );
  }
}
