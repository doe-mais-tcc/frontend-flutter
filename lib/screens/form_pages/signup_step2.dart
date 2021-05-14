import 'package:doe_mais/components/general/checkbox_form_field.dart';
import 'package:doe_mais/components/utils/form_step.dart';
import 'package:doe_mais/components/general/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:password_credential/credentials.dart';
import 'package:password_credential/entity/mediation.dart';

class SignupStep2 extends StatefulWidget implements FormStep {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _pwd1Controller = TextEditingController();
  final _pwd2Controller = TextEditingController();

  bool validate() {
    if (!_formKey.currentState.validate()) return false;
    if (_pwd1Controller.text != _pwd2Controller.text) return false;

    //Request user to save credentials
    Credentials().store(
      _emailController.text,
      _pwd1Controller.text,
      mediation: Mediation.Optional,
    );
    return true;
  }

  dynamic returnData() {
    return {
      'email': _emailController.text,
      'senha': _pwd1Controller.text,
    };
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
            autofillHints: [AutofillHints.username, AutofillHints.email],
            validator: (data) {
              var valid = _validateField(data);
              if (valid != null) return valid;
              if (!data.contains('@')) return 'Insira um email valido';
              return null;
            },
          ),
          TextFormField(
            controller: widget._pwd1Controller,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Insira sua senha*'),
            autofillHints: [AutofillHints.password],
            validator: _validateField,
          ),
          TextFormField(
            controller: widget._pwd2Controller,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Repita sua senha*'),
            autofillHints: [AutofillHints.password],
            validator: (data) {
              if (data == null || data.toString().isEmpty) return 'Obrigatório';
              if (widget._pwd1Controller.text != data)
                return 'Digite a mesma senha';
              return null;
            },
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
