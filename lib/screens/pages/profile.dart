import 'package:doe_mais/components/confirmation_card.dart';
import 'package:doe_mais/components/hospital_card.dart';
import 'package:doe_mais/models/hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Profile extends StatelessWidget {
  final Hospital hospital = Hospital(
      name: 'Hemocentro', location: 'Endereço', phone: '(13) 99999-9999');

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        Text('Este é seu perfil!',
            style: Theme.of(context).textTheme.headline1),
        ConfirmationCard(
          title: 'Teste de aptidão para doação de sangue',
          description: 'Entenda as recomendações necessárias para doar sangue',
          confirmMessage: 'Começar o teste',
          icon: SvgPicture.asset('assets/images/icon_test.svg'),
          onConfirm: () {},
        ),
        ConfirmationCard(
          title: 'Agendamento de doação',
          description: 'Você não tem nenhuma doação marcada. Marque uma!',
          confirmMessage: 'Marcar doação',
          icon: SvgPicture.asset('assets/images/icon_calendar.svg'),
          onConfirm: () {},
        ),
        Text(
          'Todos os Hemocentros na região',
          style: Theme.of(context).textTheme.headline2,
        ),
        HospitalCard(hospital),
      ],
    );
  }
}
