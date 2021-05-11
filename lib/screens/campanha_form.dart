import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/components/buttons/custom_outlined_button.dart';
import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/screens/form_pages/campanha_step1.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/custom_dialog.dart';
import 'package:flutter/material.dart';

class CampanhaForm extends StatelessWidget {
  void _onValidForm(BuildContext context, Campanha campanha) {
    CampanhaDao.postCampanha(campanha).then(
      (response) {
        customDialog(
          context: context,
          title: 'Parabéns! Você cirou uma campanha de doação!',
          message: 'Você também pode compartilhar essa campanha no facebook =D',
          secondaryButton: CustomOutlinedButton(
            label: 'Ir para campanhas',
            onPressed: () => Navigator.of(context).pushNamed('/campanhas'),
          ),
          primaryButton: CustomElevatedButton(
            label: 'Compartilhar',
            onPressed: () {},
          ),
        );
      },
    ).onError(
      (error, stackTrace) {
        return alertBottomSheet(
          context: context,
          message: 'Não foi possível criar a campanha',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CampanhaStep1(
              onValidate: (campanha) => _onValidForm(context, campanha),
            ),
          ),
        ),
      ),
    );
  }
}
