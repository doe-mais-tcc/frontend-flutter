import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/components/buttons/custom_outlined_button.dart';
import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/screens/form_pages/campanha_step1.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/custom_dialog.dart';
import 'package:flutter/material.dart';
import 'package:doe_mais/utils/navigation.dart' show Pages;

class CampanhaForm extends StatelessWidget {
  void _dialog(BuildContext context, String text) {
    customDialog(
      context: context,
      title: '$text',
      message: 'Você também pode compartilhar essa campanha nas redes sociais',
      secondaryButton: CustomOutlinedButton(
        label: 'Ir para campanhas',
        onPressed: () => Navigator.of(context).pushNamed('/campanhas'),
      ),
      primaryButton: CustomElevatedButton(
        label: 'Compartilhar',
        onPressed: () {},
      ),
    );
  }

  void _createCampanha(BuildContext context, Campanha campanha) {
    CampanhaDao.postCampanha(campanha).then(
      (response) {
        _dialog(context, 'Parabéns, você criou uma campanha de doação!');
      },
    ).onError(
      (dynamic error, stackTrace) {
        alertBottomSheet(
          context: context,
          message: 'Não foi possível criar a campanha',
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      page: Pages.Campanhas,
      child: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: CampanhaStep1(
              onValid: (campanha) => _createCampanha(context, campanha),
            ),
          ),
        ),
      ),
    );
  }
}
