import 'package:doe_mais/components/buttons/custom_button_bar.dart';
import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/components/buttons/custom_outlined_button.dart';
import 'package:doe_mais/components/general/checkbox_form_field.dart';
import 'package:doe_mais/components/utils/form_frame.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class CampanhaStep1 extends StatefulWidget {
  final Function(Campanha) onValid;
  CampanhaStep1({this.onValid});

  @override
  _CampanhaStep1State createState() => _CampanhaStep1State();
}

class _CampanhaStep1State extends State<CampanhaStep1> {
  final formKey = GlobalKey<FormState>();
  final nomeController = TextEditingController();
  final tipoSanguineoController = TextEditingController();
  final descricaoController = TextEditingController();
  List<Hemocentro> hemocentroList = [];
  int hemocentroIndex;
  bool compartilhavel = false;
  bool consentimento = false;

  void _validateForm() {
    if (!formKey.currentState.validate()) return;

    var campanha = Campanha(
      compartilhavel: compartilhavel,
      descricao: descricaoController.text,
      hemocentro: hemocentroList[hemocentroIndex],
      nomeInternado: nomeController.text,
      tipoSanguineo: tipoSanguineoController.text,
      user: SessionManager.currentUser,
    );

    widget.onValid(campanha);
  }

  String _validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
  }

  List<DropdownMenuItem<String>> _bloodDropdownItems() =>
      ['Qualquer tipo', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
          .map((e) => DropdownMenuItem(
                child: Text('$e'),
                value: e,
              ))
          .toList();

  @override
  void initState() {
    HemocentroDao.getHemocentros().then(
      (value) => setState(() => hemocentroList = value),
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FormFrame(
      formKey: formKey,
      title: 'Preencha os dados da pessoa que necessita da doação',
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Column(
            children: [
              TextFormField(
                controller: nomeController,
                keyboardType: TextInputType.name,
                decoration:
                    InputDecoration(hintText: 'Insira o nome do internado*'),
                validator: _validateField,
              ),
              DropdownButtonFormField(
                items: _bloodDropdownItems(),
                decoration: InputDecoration(
                    labelText: 'Selecione o sangue preferencial*'),
                onChanged: (dynamic value) =>
                    tipoSanguineoController.text = value,
                value: tipoSanguineoController.text.isEmpty
                    ? null
                    : tipoSanguineoController.text,
                validator: _validateField,
              ),
              hemocentroList.isEmpty
                  ? DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(child: Text('Carregando Hemocentros')),
                      ],
                      validator: _validateField,
                    )
                  : DropdownButtonFormField<int>(
                      items: List.generate(
                          hemocentroList.length,
                          (index) => DropdownMenuItem(
                                child: Text(hemocentroList[index].nome),
                                value: index,
                              )),
                      decoration: InputDecoration(
                          labelText: 'Selecione o local de internação*'),
                      onChanged: (value) => hemocentroIndex = value,
                      validator: _validateField,
                      value: hemocentroIndex,
                    ),
              Scrollbar(
                child: TextFormField(
                  controller: descricaoController,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                      hintText: 'Insira uma mensagem para a campanha'),
                  maxLines: 8,
                  maxLength: 1000,
                ),
              ),
            ],
          ),
        ),
        CheckboxFormField(
          title: Text(
              'Eu confirmo que os dados inseridos são legítimos e que tenho o consentimento do indivíduo*'),
          onSaved: (value) => setState(() => consentimento = value),
          validator: (value) => !value ? 'Obrigatório' : null,
        ),
        CheckboxListTile(
          title: Text(
              'Eu aceito que terceiros possam compartilhar em redes sociais minha campanha'),
          controlAffinity: ListTileControlAffinity.leading,
          value: compartilhavel,
          onChanged: (value) => setState(() => compartilhavel = value),
        ),
        SizedBox(height: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 420),
          child: CustomButtonBar(
            buttons: [
              CustomOutlinedButton(
                label: 'Cancelar',
                onPressed: () => Navigator.of(context).pop(),
              ),
              CustomElevatedButton(
                label: 'Criar Campanha',
                onPressed: _validateForm,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
