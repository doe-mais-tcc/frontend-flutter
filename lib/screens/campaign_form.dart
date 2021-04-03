import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/checkbox_form_field.dart';
import 'package:doe_mais/components/custom_button_bar.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/components/custom_outlined_button.dart';
import 'package:doe_mais/components/form_frame.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CampaignForm extends StatefulWidget {
  @override
  _CampaignFormState createState() => _CampaignFormState();
}

class _CampaignFormState extends State<CampaignForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _localController = TextEditingController();
  final _bloodController = TextEditingController();
  final _descriptionController = TextEditingController();
  bool shareCheck = false;
  bool postCheck = false;

  List<DropdownMenuItem<String>> _bloodDropdownItems() =>
      ['Qualquer tipo', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
          .map((e) => DropdownMenuItem(
                child: Text('$e'),
                value: '$e',
              ))
          .toList();

  String validateField(dynamic data) {
    if (data == null || data.toString().isEmpty) return 'Obrigatório';
    return null;
  }

  void validateForm(BuildContext context) {
    if (!_formKey.currentState.validate()) return;
    CampanhaDao.postCampanha(
      Campanha(
        nome: _nameController.text,
        cidade: _localController.text,
        descricao: _descriptionController.text,
      ),
    )
        .then(
          (value) => Navigator.of(context).pop(),
        )
        .onError(
          (error, stackTrace) => alertBottomSheet(
            context: context,
            message: 'Não foi possível criar a campanha',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: FormFrame(
            formKey: _formKey,
            title: 'Preencha os dados da pessoa que necessita da doação',
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 400),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _nameController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(hintText: 'Insira o nome*'),
                      validator: validateField,
                    ),
                    TextFormField(
                      controller: _localController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Insira o local de internação*'),
                      validator: validateField,
                    ),
                    DropdownButtonFormField(
                      items: _bloodDropdownItems(),
                      decoration: InputDecoration(
                          labelText: 'Insira o sangue preferencial*'),
                      onChanged: (value) => _bloodController.text = value,
                    ),
                    TextFormField(
                      controller: _descriptionController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Insira o texto da campanha'),
                      maxLines: 5,
                    ),
                  ],
                ),
              ),
              CheckboxFormField(
                initialValue: shareCheck,
                onSaved: (value) => setState(() => shareCheck = value),
                title: Text(
                    'Eu aceito que terceiros possam compartilhar em redes sociais minha campanha'),
              ),
              CheckboxFormField(
                initialValue: postCheck,
                onSaved: (value) => setState(() => shareCheck = value),
                title: Text(
                    'Eu aceito que minha campanha seja mostrada na plataforma Doe+'),
                validator: (value) => !value ? 'Obrigatório' : null,
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
                      onPressed: () => validateForm(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
