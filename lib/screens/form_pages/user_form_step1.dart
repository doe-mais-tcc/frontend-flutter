import 'package:doe_mais/components/utils/form_step.dart';
import 'package:doe_mais/models/data_holder.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';

class UserFormStep1 extends StatefulWidget implements FormStep {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();
  final _bloodController = TextEditingController();
  final _sexController = TextEditingController();
  final _birthDate = DataHolder();

  @override
  final User editObject;
  UserFormStep1(this.editObject);

  @override
  _UserFormStep1State createState() => _UserFormStep1State();

  @override
  dynamic returnData() {
    _nameController.text = _nameController.text.trim();
    return {
      'nome': _nameController.text,
      'cidade': _cityController.text,
      'tipo_sanguineo': _bloodController.text,
      'data_nascimento': DateFormat('dd-MM-yyyy').format(_birthDate.data),
      'sexo': _sexController.text,
    };
  }

  @override
  bool validate() {
    return _formKey.currentState.validate();
  }
}

class _UserFormStep1State extends State<UserFormStep1> {
  List<String> cidades = [];

  String _validateField(dynamic data) {
    if (data == null ||
        data.toString().isEmpty ||
        (data is String && data.trim().isEmpty)) return 'Obrigatório';
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

  void updateFields() {
    if (widget.editObject == null) {
      widget._sexController.text = 'M';
      widget._bloodController.text = _bloodValues[0];
    } else {
      widget._nameController.text = widget.editObject.nome;
      widget._bloodController.text = widget.editObject.sangue;
      widget._birthDate.data = widget.editObject.nascimento;
      widget._sexController.text = widget.editObject.sexo;
      widget._cityController.text = widget.editObject.cidade;
    }
  }

  @override
  void initState() {
    updateFields();

    super.initState();

    HemocentroDao.getCidades().then(
      (result) => setState(() {
        cidades = result;
        if (widget.editObject != null)
          widget._cityController.text = widget.editObject.cidade;
        else
          widget._cityController.text = cidades[0];
      }),
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
          Text('Dados pessoais', style: Theme.of(context).textTheme.headline2),
          TextFormField(
            controller: widget._nameController,
            autofillHints: [AutofillHints.name],
            keyboardType: TextInputType.text,
            decoration:
                InputDecoration(labelText: 'Insira seu nome e sobrenome*'),
            validator: (data) {
              var valid = _validateField(data);
              if (valid != null) return valid;
              if (!data.contains(' ')) return 'Insira nome e sobrenome';
              return null;
            },
          ),
          DropdownButtonFormField(
            items: _bloodDropdownItems(),
            decoration: InputDecoration(labelText: 'Selecione seu sangue*'),
            onChanged: (value) {
              widget._bloodController.text = value;
            },
            value: widget._bloodController.text,
            validator: _validateField,
          ),
          cidades.isEmpty
              ? DropdownButtonFormField(
                  items: [
                    DropdownMenuItem(
                      child: Text(''),
                    )
                  ],
                  decoration: InputDecoration(labelText: 'Carregando cidades'),
                  validator: _validateField,
                )
              : DropdownButtonFormField(
                  items: cidades
                      .map((e) => DropdownMenuItem(child: Text(e), value: e))
                      .toList(),
                  decoration:
                      InputDecoration(labelText: 'Selecione sua cidade*'),
                  onChanged: (value) => widget._cityController.text = value,
                  value: widget._cityController.text,
                  validator: _validateField,
                ),
          DateTimeField(
            format: DateFormat('dd/MM/yyyy'),
            decoration: InputDecoration(labelText: 'Insira seu nascimento*'),
            initialValue: widget._birthDate.data,
            onShowPicker: (BuildContext context, DateTime currentValue) {
              DateTime now = DateTime.now();
              var initialDate = DateTime(now.year - 14);
              return showDatePicker(
                context: context,
                initialDate: currentValue ?? initialDate,
                firstDate: DateTime(now.year - 100),
                lastDate: initialDate,
              ).then((date) {
                if (date != null) widget._birthDate.data = date;
                return widget._birthDate.data;
              });
            },
            validator: _validateField,
          ),
          SizedBox(height: 20),
          Text(
            'Selecione seu sexo biológico:*',
            style: TextStyle(color: Theme.of(context).indicatorColor),
          ),
          RadioListTile<String>(
            title: Text('Masculino'),
            value: 'M',
            groupValue: widget._sexController.text,
            onChanged: (value) =>
                setState(() => widget._sexController.text = value),
          ),
          RadioListTile<String>(
            title: Text('Feminino'),
            value: 'F',
            groupValue: widget._sexController.text,
            onChanged: (value) =>
                setState(() => widget._sexController.text = value),
          ),
        ],
      ),
    );
  }
}
