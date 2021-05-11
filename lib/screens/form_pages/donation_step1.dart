import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/models/doacao.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/doacao_dao.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:doe_mais/utils/date_time_extension.dart';

class DonationStep1 extends StatefulWidget {
  @override
  _DonationStep1State createState() => _DonationStep1State();
}

class _DonationStep1State extends State<DonationStep1> {
  final formKey = GlobalKey<FormState>();
  final timeController = TextEditingController();
  TimeOfDay doacaoTime = TimeOfDay(hour: 12, minute: 00);
  DateTime doacaoDate = DateTime.now();
  Hemocentro doacaoHemocentro;

  String _validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
  }

  void _validateForm(BuildContext context) {
    if (!formKey.currentState.validate()) return;

    var doacao = Doacao(
      user: SessionManager.currentUser,
      proximaDoacao: doacaoDate.setTimeOfDay(doacaoTime),
      hemocentro: doacaoHemocentro,
    );
    DoacaoDao.postDoacao(doacao)
        .then(
      (result) => Navigator.of(context).pop(doacao),
    )
        .onError(
      (error, stackTrace) {
        alertBottomSheet(
            context: context, message: 'Não foi possível criar o lembrete');
      },
    );
  }

  Widget _calendarStep(ThemeData theme) {
    var now = DateTime.now();
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
          onDateChanged: (date) => setState(() => doacaoDate = date),
        ),
        SizedBox(height: 20),
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
            initialTime: TimeOfDay(hour: 12, minute: 00),
          ).then(
            (value) {
              if (value == null) return;
              doacaoTime = value;
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
        FutureBuilder<List<Hemocentro>>(
          future: HemocentroDao.getHemocentros(),
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return DropdownButtonFormField(
                items: [],
                decoration:
                    InputDecoration(labelText: 'Erro ao carregar hemocentros'),
                validator: _validateField,
              );

            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData)
              return DropdownButtonFormField<Hemocentro>(
                items: snapshot.data
                    .map((e) => DropdownMenuItem(
                          child: Text(e.nome),
                          value: e,
                        ))
                    .toList(),
                decoration:
                    InputDecoration(labelText: 'Selecione o local da doação*'),
                onChanged: (value) => doacaoHemocentro = value,
                validator: _validateField,
              );
            return DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text('Carregando Hemocentros'),
                ),
              ],
              validator: _validateField,
            );
          },
        ),
      ],
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
