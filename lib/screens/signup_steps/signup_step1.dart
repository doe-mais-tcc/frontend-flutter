import 'package:doe_mais/components/form_step.dart';
import 'package:doe_mais/models/userModel.dart';
import 'package:flutter/material.dart';

class SignupStep1 extends StatelessWidget implements FormStep {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _bloodController = TextEditingController();

  bool validate() {
    return _formKey.currentState.validate();
  }

  dynamic returnData() {
    return UserModel(
      nome: _nameController.text,
      cidade: _cityController.text,
      sangue: _bloodController.text,
    );
  }

  String _validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
  }

  final _bloodValues = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<DropdownMenuItem> _bloodDropdownItems() {
    return _bloodValues
        .map((e) => DropdownMenuItem(
              child: Text('$e'),
              value: '$e',
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_bloodController.text.isEmpty) 
      _bloodController.text = _bloodValues[0];

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('*obrigatório'),
          Text('Dados pessoais', style: Theme.of(context).textTheme.headline2),
          TextFormField(
            controller: _nameController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Insira seu nome*'),
            validator: _validateField,
          ),
          DropdownButtonFormField(
            items: _bloodDropdownItems(),
            decoration: InputDecoration(labelText: 'Insira seu sangue*'),
            value: _bloodController.text,
            onChanged: (value) => _bloodController.text = value,
            validator: _validateField,
          ),
          TextFormField(
            controller: _cityController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(labelText: 'Insira sua cidade*'),
            validator: _validateField,
          ),
          // TextFormField(
          //   controller: _birthDateController,
          //   keyboardType: TextInputType.datetime,
          //   decoration:
          //       InputDecoration(labelText: 'Insira seu nascimento*'),
          //   validator: (data) => data.isEmpty ? 'Obrigatório' : null,
          // ),
        ],
      ),
    );
  }
}
