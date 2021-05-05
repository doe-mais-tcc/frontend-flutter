import 'package:doe_mais/components/confirmation_card.dart';
import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/responsive_row_min.dart';
import 'package:doe_mais/utils/donation_dialog.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class Perfil extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Este é seu perfil!',
              style: Theme.of(context).textTheme.headline1),
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
              ConfirmationCard(
                title: 'Requisitos para a doação de sangue',
                description:
                    'Entenda as recomendações necessárias para doar sangue',
                confirmMessage: 'Ver requisitos',
                icon: Image.asset('assets/images/icon_test.png'),
                onConfirm: () =>
                    Navigator.of(context).pushNamed('/requisitos-doacao'),
              ),
              ConfirmationCard(
                title: 'Lembrete de doação',
                description:
                    'Você não tem nenhum lembrete de doação marcado. Marque um!',
                confirmMessage: 'Marcar lembrete',
                icon: Image.asset('assets/images/icon_calendar.png'),
                onConfirm: () => donationDialog(context)
                    .then((doacao) => print(doacao?.data)),
              ),
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
