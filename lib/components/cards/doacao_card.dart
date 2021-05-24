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

  @override
  Widget build(BuildContext context) {
    final diff = doacao?.proximaDoacao?.difference(DateTime.now())?.inDays;
    if (doacao == null)
      return ConfirmationCard(
        title: 'Lembrete de doação',
        description: 'Você não tem nenhum lembrete de doação. Marque um!',
        icon: Image.asset('assets/images/icon_calendar.png'),
        confirmWidget: CustomElevatedButton(
          label: 'Marcar um lembrete',
          onPressed: () async {
            var donation = await donationDialog(context);
            if (donation == null) return;

            ScoreManager.addScore(3);
            onModify(donation);
            messageBottomSheet(
                context: context,
                message: 'Lembrete de doação de sangue marcado!');
          },
        ),
      );
    else
      return ConfirmationCard(
        title: 'Lembrete de doação',
        description:
            'Seu lembrete de doação está marcado para\n${DateFormat("dd/MM/yyyy 'as' hh:mm").format(doacao.proximaDoacao)}',
        info: diff.isNegative ? 'Concluido' : '$diff dias',
        fontSize: diff.isNegative ? 20 : 30,
        confirmWidget: Row(
          children: [
            Flexible(
              child: CustomOutlinedButton(
                label: 'Apagar',
                onPressed: () async {
                  bool result = await _confirmDialog(context);
                  if (!result) return;

                  await DoacaoDao.deleteDoacao(doacao);
                  onModify(null);
                  messageBottomSheet(
                      context: context, message: 'Seu lembrete foi apagado');
                },
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: CustomElevatedButton(
                label: 'Editar',
                onPressed: () async {
                  var donation = await donationDialog(context, doacao);
                  if (donation == null) return;
                  await DoacaoDao.updateDoacao(donation);
                  onModify(donation);
                  messageBottomSheet(
                      context: context,
                      message: 'Lembrete de doação de sangue editado!');
                },
              ),
            ),
          ],
        ),
      );
  }
}
