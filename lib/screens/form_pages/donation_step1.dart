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
  final Doacao editDoacao;
  DonationStep1({this.editDoacao});

  @override
  _DonationStep1State createState() => _DonationStep1State();
}

class _DonationStep1State extends State<DonationStep1> {
  final formKey = GlobalKey<FormState>();
  final timeController = TextEditingController();
  DateTime doacaoDate = DateTime.now();
  TimeOfDay doacaoTime;
  List<Hemocentro> hemocentroList = [];
  Hemocentro doacaoHemocentro;

  String _validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
  }

  void _validateForm(BuildContext context) {
    if (!formKey.currentState.validate()) return;

    // Update properties from given doação or new doação
    Doacao doacao = widget.editDoacao ?? Doacao()
      ..user = SessionManager.currentUser
      ..proximaDoacao = doacaoDate.setTimeOfDay(doacaoTime)
      ..hemocentro = doacaoHemocentro;

    // Update if given a doação, else post new doação
    if (widget.editDoacao == null)
      DoacaoDao.postDoacao(doacao)
          .then((result) => Navigator.of(context).pop(result))
          .onError((error, stackTrace) {
        alertBottomSheet(
            context: context, message: 'Não foi possível criar o lembrete');
      });
    else
      DoacaoDao.updateDoacao(doacao)
          .then((result) => Navigator.of(context).pop(result))
          .onError((error, stackTrace) {
        alertBottomSheet(
            context: context, message: 'Não foi possível atualizar o lembrete');
      });
  }

  // Calendar Widget
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
          initialDate: doacaoDate.isBefore(now) ? now : doacaoDate,
          firstDate: now,
          lastDate: DateTime(3000),
          onDateChanged: (date) => setState(() => doacaoDate = date),
        ),
        SizedBox(height: 20),
      ],
    );
  }

  // Time Widget
  Widget _timeStep(ThemeData theme) {
    if (doacaoTime != null) timeController.text = doacaoTime.format(context);
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
            initialTime: doacaoTime ?? TimeOfDay(hour: 12, minute: 0),
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

  // Hemocentro Widget
  Widget _hemocentroStep(ThemeData theme) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Selecione o local de doação',
          style: theme.textTheme.headline2,
        ),
        hemocentroList.isEmpty
            ? DropdownButtonFormField(
                items: [
                  DropdownMenuItem(
                    child: Text('Carregando Hemocentros'),
                  ),
                ],
                validator: _validateField,
              )
            : DropdownButtonFormField<Hemocentro>(
                value: doacaoHemocentro,
                items: hemocentroList
                    .map((e) => DropdownMenuItem(
                          child: Text(e.nome),
                          value: e,
                        ))
                    .toList(),
                decoration:
                    InputDecoration(labelText: 'Selecione o local da doação*'),
                onChanged: (value) => doacaoHemocentro = value,
                validator: _validateField,
              ),
      ],
    );
  }

  @override
  void initState() {
    // Get editDoacao data
    if (widget.editDoacao != null)
      setState(() {
        var _date = widget.editDoacao.proximaDoacao;
        doacaoDate = _date;
        doacaoTime = _date.extractTimeOfDay();
        doacaoHemocentro = widget.editDoacao.hemocentro;
      });

    // Get hemocentro list
    HemocentroDao.getHemocentros()
        .then((value) => setState(() => hemocentroList = value));

    super.initState();
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
              onPressed: () {
                _validateForm(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
