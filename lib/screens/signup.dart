import 'package:doe_mais/components/checkbox_form_field.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/components/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _emailController = TextEditingController();
  final _pwd1Controller = TextEditingController();
  final _pwd2Controller = TextEditingController();
  DateTime _birthDate;
  bool _termsCheckbox = false;
  int _selectedBlood = 0;

  final _bloodValues = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<DropdownMenuItem> _bloodDropdownItems() {
    return _bloodValues
        .map((e) => DropdownMenuItem(
              child: Text('$e'),
              value: '$e',
            ))
        .toList();
  }

  String _validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
  }

  void _validate() {
    if (!_formKey.currentState.validate()) return;
    if (_pwd1Controller.text != _pwd2Controller.text) return;
    //TO-DO: enviar dados para o banco
  }

  void _openModal() {
    showDialog(
      context: context,
      builder: (context) => Modal(
        title: 'Termos de Uso',
        content: 'lorem ipsum',
        submitLabel: 'Aceitar',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 100, horizontal: 40),
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                width: 60,
                semanticsLabel: 'Logo Doe mais',
              ),
              Text('*obrigatório'),
              Text('Dados pessoais',
                  style: Theme.of(context).textTheme.headline1),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(labelText: 'Insira seu nome*'),
                      validator: _validateField,
                    ),
                    DropdownButtonFormField(
                      items: _bloodDropdownItems(),
                      decoration:
                          InputDecoration(labelText: 'Insira seu sangue*'),
                      onChanged: (value) => _selectedBlood = value,
                      validator: _validateField,
                    ),
                    TextFormField(
                      controller: _cityController,
                      keyboardType: TextInputType.text,
                      decoration:
                          InputDecoration(labelText: 'Insira sua cidade*'),
                      validator: _validateField,
                    ),
                    // TextFormField(
                    //   controller: _birthDateController,
                    //   keyboardType: TextInputType.datetime,
                    //   decoration:
                    //       InputDecoration(labelText: 'Insira seu nascimento*'),
                    //   validator: (data) => data.isEmpty ? 'Obrigatório' : null,
                    // ),
                    Text('*obrigatório'),
                    Text('Dados de acesso*',
                        style: Theme.of(context).textTheme.headline1),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                          InputDecoration(labelText: 'Insira seu email*'),
                      validator: _validateField,
                    ),
                    TextFormField(
                      controller: _pwd1Controller,
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: 'Insira sua senha*'),
                      validator: _validateField,
                    ),
                    TextFormField(
                      controller: _pwd2Controller,
                      obscureText: true,
                      decoration:
                          InputDecoration(labelText: 'Repita sua senha*'),
                      validator: _validateField,
                    ),
                    CheckboxFormField(
                      title: TextButton(
                        child: Text(
                          'Li e aceito os termos e condições de uso',
                          textAlign: TextAlign.left,
                        ),
                        onPressed: _openModal,
                      ),
                      initialValue: _termsCheckbox,
                      onSaved: (value) =>
                          setState(() => _termsCheckbox = value),
                      validator: (value) => !value ? 'Obrigatório' : null,
                    ),
                    CustomElevatedButton(
                      label: 'Confirmar',
                      onPressed: _validate,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
