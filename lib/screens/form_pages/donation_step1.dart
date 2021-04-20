import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/models/doacao.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:flutter/material.dart';

class DonationStep1 extends StatefulWidget {
  @override
  _DonationStep1State createState() => _DonationStep1State();
}

class _DonationStep1State extends State<DonationStep1> {
  final now = DateTime.now();
  final doacao = Doacao();
  final formKey = GlobalKey<FormState>();
  final timeController = TextEditingController();
  List<Hemocentro> hemocentros = [];

  String _validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
  }

  void _validateForm(BuildContext context) {
    if (!formKey.currentState.validate()) return;
    Navigator.of(context).pop(doacao);
  }

  Widget _calendarStep(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selecione o dia',
          style: theme.textTheme.headline2,
        ),
        CalendarDatePicker(
          initialDate: now,
          firstDate: now,
          lastDate: DateTime(3000),
          onDateChanged: (date) => doacao.data = date,
        ),
      ],
    );
  }

  Widget _timeStep(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selecione o horário',
          style: theme.textTheme.headline2,
        ),
        TextFormField(
          readOnly: true,
          controller: timeController,
          decoration: InputDecoration(labelText: 'Insira o horário da doação*'),
          onTap: () => showTimePicker(
            context: context,
            initialTime: TimeOfDay(hour: 00, minute: 00),
          ).then(
            (value) {
              doacao.hora = value;
              timeController.text = value.format(context);
            },
          ),
          validator: _validateField,
        ),
      ],
    );
  }

  Widget _hemocentroStep(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selecione o local de doação',
          style: theme.textTheme.headline2,
        ),
        hemocentros.isEmpty
            ? DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    child: Text('Carregando Hemocentros'),
                  ),
                ],
                validator: _validateField,
              )
            : DropdownButtonFormField<Hemocentro>(
                items: hemocentros
                    .map((e) => DropdownMenuItem(
                          child: Text(e.nome),
                          value: e,
                        ))
                    .toList(),
                decoration:
                    InputDecoration(labelText: 'Selecione o local da doação*'),
                onChanged: (value) => doacao.hemocentro = value,
                validator: _validateField,
              ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    doacao.data = now;
    HemocentroDao.getHemocentros().then(
      (list) => setState(() => hemocentros = list),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Marcar lembrete de doação',
            style: theme.textTheme.headline1,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 40),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 20,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 350),
                child: _calendarStep(theme),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  children: [
                    _timeStep(theme),
                    SizedBox(height: 30),
                    _hemocentroStep(theme),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 250,
            child: CustomElevatedButton(
              label: 'Marcar Lembrete',
              onPressed: () => _validateForm(context),
            ),
          ),
        ],
      ),
    );
  }
}
