import 'package:doe_mais/components/confirmation_card.dart';
import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/responsive_row_min.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/donation_dialog.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class Perfil extends StatelessWidget {
  Widget _requisitosCard(BuildContext context) {
    return ConfirmationCard(
      title: 'Requisitos para a doação de sangue',
      description: 'Entenda as recomendações necessárias para doar sangue',
      confirmMessage: 'Ver requisitos',
      icon: Image.asset('assets/images/icon_test.png'),
      onConfirm: () => Navigator.of(context).pushNamed('/requisitos-doacao'),
    );
  }

  Widget _lembreteCard(BuildContext context) {
    return ConfirmationCard(
      title: 'Lembrete de doação',
      description: 'Você não tem nenhum lembrete de doação marcado. Marque um!',
      confirmMessage: 'Marcar lembrete',
      icon: Image.asset('assets/images/icon_calendar.png'),
      onConfirm: () {
        if (SessionManager.currentUser == null) {
          Navigator.of(context).pushNamed('/login');
          return null;
        }
        donationDialog(context).then(
          (doacao) {
            messageBottomSheet(
                context: context,
                message: 'Parabéns! Você criou um lembrete de doação');
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Este é seu perfil!',
                style: Theme.of(context).textTheme.headline1),
          ),
          ResponsiveRowMin(
            mainAxisAlignment: MainAxisResponsiveRowAlignment.center,
            crossAxisAlignment: CrossAxisResponsiveRowAlignment.stretch,
            mainAxisSpacing: 20,
            height: 370,
            columnWidth: ColumnWidth(
              lgUp: 5,
              md: 6,
              smDown: 12,
            ),
            children: [
              _requisitosCard(context),
              _lembreteCard(context),
            ],
          ),
          Text(
            'Todos os Hemocentros na região',
            style: Theme.of(context).textTheme.headline2,
          ),
        ],
      ),
    );
  }
}
