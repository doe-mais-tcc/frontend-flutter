import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/components/buttons/custom_outlined_button.dart';
import 'package:doe_mais/components/cards/confirmation_card.dart';
import 'package:doe_mais/models/doacao.dart';
import 'package:doe_mais/services/doacao_dao.dart';
import 'package:doe_mais/utils/confirm_dialog.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/donation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DoacaoCard extends StatelessWidget {
  final Doacao doacao;
  final Function(Doacao) onModify;
  DoacaoCard({@required this.doacao, @required this.onModify});

  String _contentString() {
    Duration diff = doacao.proximaDoacao.difference(DateTime.now());
    if (diff.isNegative) return '0 dias';
    return '${diff.inDays} dias';
  }

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
    if (doacao == null)
      return ConfirmationCard(
        title: 'Lembrete de doação',
        description: 'Você não tem nenhum lembrete de doação. Marque um!',
        icon: Image.asset('assets/images/icon_calendar.png'),
        confirmWidget: CustomElevatedButton(
          label: 'Marcar um lembrete',
          onPressed: () => donationDialog(context).then(
            (donation) {
              if (donation != null) {
                messageBottomSheet(
                    context: context,
                    message: 'Lembrete de doação de sangue marcado!');
                onModify(donation);
              }
            },
          ),
        ),
      );
    else
      return ConfirmationCard(
        title: 'Lembrete de doação',
        description:
            'Seu lembrete de doação está marcado para\n${DateFormat("dd/MM/yyyy 'as' hh:mm").format(doacao.proximaDoacao)}',
        info: _contentString(),
        confirmWidget: Row(
          children: [
            Flexible(
              child: CustomOutlinedButton(
                label: 'Apagar',
                onPressed: () async {
                  bool result = await _confirmDialog(context);

                  if (result) {
                    await DoacaoDao.deleteDoacao(doacao);
                    messageBottomSheet(
                        context: context, message: 'Seu lembrete foi apagado');
                    onModify(null);
                  }
                },
              ),
            ),
            SizedBox(width: 10),
            Flexible(
              child: CustomElevatedButton(
                label: 'Editar',
                onPressed: () => donationDialog(context, doacao).then(
                  (donation) {
                    if (donation != null) {
                      messageBottomSheet(
                          context: context,
                          message: 'Lembrete de doação de sangue editado!');
                      onModify(donation);
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      );
  }
}
