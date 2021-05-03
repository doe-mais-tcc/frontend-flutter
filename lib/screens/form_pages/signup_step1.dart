import 'package:doe_mais/components/form_step.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class SignupStep1 extends StatelessWidget implements FormStep {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _bloodController = TextEditingController();
  final _birthDate = DateTime.now();

  bool validate() {
    return _formKey.currentState.validate();
  }

  dynamic returnData() {
    return {
      'nome': _nameController.text,
      'cidade': _cityController.text,
      'sangue': _bloodController.text,
      'nascimento': DateFormat('dd-MM-yyyy').format(_birthDate),
    };
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
            decoration: InputDecoration(labelText: 'Selecione seu sangue*'),
            value: _bloodController.text,
            onChanged: (value) => _bloodController.text = value,
            validator: _validateField,
          ),
          FutureBuilder<List<String>>(
            future: HemocentroDao.getCidades(),
            builder: (context, snapshot) {
              if (!snapshot.hasData)
                return DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(
                      child: Text(''),
                    )
                  ],
                  decoration: InputDecoration(labelText: 'Carregando cidades'),
                  validator: _validateField,
                );

              var values = snapshot.data
                  .map((e) => DropdownMenuItem(child: Text(e), value: e))
                  .toList();

              _cityController.text = values[0].value;
              return DropdownButtonFormField(
                items: values,
                decoration: InputDecoration(labelText: 'Selecione sua cidade*'),
                value: _cityController.text,
                onChanged: (value) => _cityController.text = value,
                validator: _validateField,
              );
            },
          ),
          DateTimeField(
            format: DateFormat('dd-MM-yyyy'),
            decoration: InputDecoration(labelText: 'Insira seu nascimento*'),
            initialValue: _birthDate,
            onShowPicker: (BuildContext context, DateTime currentValue) {
              DateTime now = DateTime.now();
              var initialDate = DateTime(now.year - 14);
              return showDatePicker(
                context: context,
                initialDate: currentValue ?? initialDate,
                firstDate: DateTime(now.year - 100),
                lastDate: initialDate,
              ).then((date) {
                var dif = _birthDate.difference(date);
                _birthDate.add(dif);
                return null;
              });
            },
            validator: _validateField,
          ),
        ],
      ),
    );
  }
}
