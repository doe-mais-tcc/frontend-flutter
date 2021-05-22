import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/utils/confirm_dialog.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:flutter/material.dart';

class CampanhaPopupMenu extends StatelessWidget {
  static const String deleteMessage =
      'Apagar campanha? Os compartilhamentos da campanha ainda podem ser vistos nas redes sociais';

  final Campanha campanha;
  CampanhaPopupMenu(this.campanha);

  void _apagar(BuildContext context) async {
    bool result = await confirmDialog(
      context: context,
      message: deleteMessage,
      noLabel: 'Cancelar',
      yesLabel: 'Apagar',
    );
    if (!result) return;

    await CampanhaDao.deleteCampanha(campanha)
        .onError((dynamic error, stackTrace) {
      alertBottomSheet(
          context: context, message: 'Não foi possível apagar a campanha');
    }).then((_) {
      Navigator.of(context).pushReplacementNamed('/campanhas');
      messageBottomSheet(context: context, message: 'Sua campanha foi apagada');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: PopupMenuButton<Function(BuildContext)>(
        child: Icon(Icons.more_vert),
        onSelected: (value) => value(context),
        itemBuilder: (context) => [
          PopupMenuItem(
            child: Text('Apagar'),
            value: _apagar,
          ),
        ],
      ),
    );
  }
}
