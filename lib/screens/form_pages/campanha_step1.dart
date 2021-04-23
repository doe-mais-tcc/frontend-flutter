import 'package:doe_mais/components/custom_button_bar.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/components/custom_outlined_button.dart';
import 'package:doe_mais/components/form_frame.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class CampanhaStep1 extends StatefulWidget {
  final Function(Campanha) onValidate;
  CampanhaStep1({this.onValidate});

  @override
  _CampanhaStep1State createState() => _CampanhaStep1State();
}

class _CampanhaStep1State extends State<CampanhaStep1> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _tipoSanguineoController = TextEditingController();
  final _descricaoController = TextEditingController();
  List<Hemocentro> hemocentroList = [];
  int hemocentroIndex;
  bool compartilhavel = false;

  void _validateForm() {
    if (!_formKey.currentState.validate()) return;
    var campanha = Campanha(
      nomeInternado: _nomeController.text,
      tipoSanguineo: _tipoSanguineoController.text,
      descricao: _descricaoController.text,
      compartilhavel: compartilhavel,
      user: SessionManager.currentUser,
      hemocentro: hemocentroList[hemocentroIndex],
    );
    widget.onValidate(campanha);
  }

  String _validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
  }

  List<DropdownMenuItem<String>> _bloodDropdownItems() =>
      ['Qualquer tipo', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
          .map((e) => DropdownMenuItem(
                child: Text('$e'),
                value: '$e',
              ))
          .toList();

  @override
  Widget build(BuildContext context) {
    return FormFrame(
      formKey: _formKey,
      title: 'Preencha os dados da pessoa que necessita da doação',
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 400),
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                keyboardType: TextInputType.name,
                decoration:
                    InputDecoration(hintText: 'Insira o nome do internado*'),
                validator: _validateField,
              ),
              DropdownButtonFormField(
                items: _bloodDropdownItems(),
                decoration: InputDecoration(
                    labelText: 'Selecione o sangue preferencial*'),
                onChanged: (value) => _tipoSanguineoController.text = value,
                validator: _validateField,
              ),
              FutureBuilder<List<Hemocentro>>(
                future: HemocentroDao.getHemocentros(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData)
                    return DropdownButtonFormField(
                      items: [
                        DropdownMenuItem(child: Text('Carregando Hemocentros')),
                      ],
                      validator: _validateField,
                    );

                  hemocentroList = snapshot.data;
                  return DropdownButtonFormField(
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
                  );
                },
              ),
              TextFormField(
                controller: _descricaoController,
                keyboardType: TextInputType.text,
                decoration:
                    InputDecoration(hintText: 'Insira o texto da campanha'),
                maxLines: 5,
              ),
            ],
          ),
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
