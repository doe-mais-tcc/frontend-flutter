import 'package:doe_mais/components/checkbox_form_field.dart';
import 'package:doe_mais/components/form_step.dart';
import 'package:doe_mais/components/modal.dart';
import 'package:doe_mais/models/userModel.dart';
import 'package:flutter/material.dart';

class SignupStep2 extends StatefulWidget implements FormStep {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwd1Controller = TextEditingController();
  final _pwd2Controller = TextEditingController();

  bool validate() {
    if (!_formKey.currentState.validate()) return false;
    return _pwd1Controller.text == _pwd2Controller.text;
  }

  dynamic returnData() {
    return UserModel(
      email: _emailController.text,
      senha: _pwd1Controller.text,
    );
  }

  @override
  _SignupStep2State createState() => _SignupStep2State();
}

class _SignupStep2State extends State<SignupStep2> {
  bool _termsCheckbox = false;

  String _validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
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
    return Form(
      key: widget._formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('*obrigatório'),
          Text('Dados de acesso', style: Theme.of(context).textTheme.headline2),
          TextFormField(
            controller: widget._emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(labelText: 'Insira seu email*'),
            validator: _validateField,
          ),
          TextFormField(
            controller: widget._pwd1Controller,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Insira sua senha*'),
            validator: _validateField,
          ),
          TextFormField(
            controller: widget._pwd2Controller,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Repita sua senha*'),
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
            onSaved: (value) => setState(() => _termsCheckbox = value),
            validator: (value) => !value ? 'Obrigatório' : null,
          ),
        ],
      ),
    );
  }
}
