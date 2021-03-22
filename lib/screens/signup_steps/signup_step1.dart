import 'package:doe_mais/components/form_step.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/utils/data_holder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class SignupStep1 extends StatelessWidget implements FormStep {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _bloodController = TextEditingController();
  final _birthDate = DataHolder<DateTime>();

  bool validate() {
    return _formKey.currentState.validate();
  }

  dynamic returnData() {
    return User(
      nome: _nameController.text,
      cidade: _cityController.text,
      sangue: _bloodController.text,
      nascimento: _birthDate.data,
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
    if (_bloodController.text.isEmpty) _bloodController.text = _bloodValues[0];

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
          DateTimeField(
            format: DateFormat('dd-MM-yyyy'),
            decoration: InputDecoration(labelText: 'Insira seu nascimento*'),
            initialValue: _birthDate.data,
            onShowPicker: (BuildContext context, DateTime currentValue) {
              DateTime now = DateTime.now();
              return showDatePicker(
                context: context,
                initialDate: currentValue ?? now,
                firstDate: DateTime(now.year - 100),
                lastDate: DateTime.now(),
              ).then((date) => _birthDate.data = date);
            },
            validator: _validateField,
          ),
        ],
      ),
    );
  }
}
