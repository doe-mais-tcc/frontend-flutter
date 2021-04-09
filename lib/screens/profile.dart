import 'package:doe_mais/components/confirmation_card.dart';
import 'package:doe_mais/components/app_frame.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Este é seu perfil!',
              style: Theme.of(context).textTheme.headline1),
          ConfirmationCard(
            title: 'Teste de aptidão para doação de sangue',
            description:
                'Entenda as recomendações necessárias para doar sangue',
            confirmMessage: 'Começar o teste',
            icon: Image.asset('assets/images/icon_test.svg'),
            onConfirm: () =>
                Navigator.of(context).pushNamed('/perfil/requisitos-doacao'),
          ),
          ConfirmationCard(
            title: 'Agendamento de doação',
            description: 'Você não tem nenhuma doação marcada. Marque uma!',
            confirmMessage: 'Marcar doação',
            icon: Image.asset('assets/images/icon_calendar.svg'),
            onConfirm: () {},
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
