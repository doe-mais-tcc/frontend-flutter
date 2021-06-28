import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/components/buttons/custom_outlined_button.dart';
import 'package:doe_mais/components/cards/confirmation_card.dart';
import 'package:doe_mais/models/doacao.dart';
import 'package:doe_mais/services/doacao_dao.dart';
import 'package:doe_mais/utils/confirm_dialog.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/donation_dialog.dart';
import 'package:doe_mais/utils/score_manager.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoacaoCard extends StatelessWidget {
  final Doacao doacao;
  final Function(Doacao) onModify;
  DoacaoCard({@required this.doacao, @required this.onModify});

  Future<bool> _confirmDialog(BuildContext context) async {
    return await confirmDialog(
      context: context,
      message: 'Apagar lembrete de doação?',
      yesLabel: 'Apagar',
      noLabel: 'Cancelar',
    );
  }

  void _createDoacao(BuildContext context) async {
    var donation = await donationDialog(context);
    if (donation == null) return;
    doacao
      ..hemocentro = donation.hemocentro
      ..proximaDoacao = donation.proximaDoacao;
    await DoacaoDao.updateDoacao(doacao);

    ScoreManager.addScore(3);
    onModify(donation);
    messageBottomSheet(
        context: context, message: 'Lembrete de doação de sangue marcado!');
  }

  void _editDoacao(BuildContext context) async {
    var donation = await donationDialog(context, doacao);
    if (donation == null) return;

    await DoacaoDao.updateDoacao(donation);
    onModify(donation);
    messageBottomSheet(
        context: context, message: 'Lembrete de doação de sangue editado!');
  }

  void _deleteDoacao(BuildContext context) async {
    bool result = await _confirmDialog(context);
    if (!result) return;
    doacao
      ..hemocentro = null
      ..proximaDoacao = null;
    await DoacaoDao.updateDoacao(doacao);

    onModify(null);
    messageBottomSheet(context: context, message: 'Seu lembrete foi apagado');
  }

  void _confirmDoacao(BuildContext context) async {
    doacao.ultimaDoacao = doacao.proximaDoacao;
    doacao.proximaDoacao = null;
    await DoacaoDao.updateDoacao(doacao);

    ScoreManager.addScore(10);
    onModify(doacao);
    messageBottomSheet(
        context: context, message: 'Parabéns por realizar uma doação!');
  }

  @override
  Widget build(BuildContext context) {
    final diff = doacao.proximaDoacao?.difference(DateTime.now())?.inDays;

    // No reminder
    if (diff == null)
      return ConfirmationCard(
        title: 'Lembrete de doação',
        description: 'Você não tem nenhum lembrete de doação. Marque um!',
        icon: Image.asset('assets/images/icon_calendar.png'),
        confirmWidget: CustomElevatedButton(
          label: 'Marcar um lembrete',
          onPressed: () => _createDoacao(context),
        ),
      );

    // Expired reminder
    else if (diff == 0 || diff.isNegative)
      return ConfirmationCard(
        title: 'Lembrete de doação',
        description:
            'Você realizou sua doação em \n${DateFormat("dd/MM/yyyy 'as' hh:mm").format(doacao.proximaDoacao)}?',
        info: 'Concluido',
        fontSize: 18,
        confirmWidget: Wrap(
          children: [
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 150),
              child: CustomOutlinedButton(
                label: 'Remarcar',
                onPressed: () => _editDoacao(context),
              ),
            ),
            SizedBox(width: 10),
            ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 150),
              child: CustomElevatedButton(
                label: 'Confirmar',
                onPressed: () => _confirmDoacao(context),
              ),
            ),
          ],
        ),
      );
    // Ongoing reminder
    else
      return ConfirmationCard(
        title: 'Lembrete de doação',
        description:
            'Seu lembrete de doação está marcado para \n${DateFormat("dd/MM/yyyy 'as' hh:mm").format(doacao.proximaDoacao)}',
        info: '$diff dias',
        fontSize: 30,
        confirmWidget: Row(
          children: [
            Flexible(
              child: CustomOutlinedButton(
                label: 'Apagar',
                onPressed: () => _deleteDoacao(context),
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: CustomElevatedButton(
                label: 'Editar',
                onPressed: () => _editDoacao(context),
              ),
            ),
          ],
        ),
      );
  }
}
