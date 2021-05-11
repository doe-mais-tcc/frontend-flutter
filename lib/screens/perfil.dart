import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/components/cards/confirmation_card.dart';
import 'package:doe_mais/components/cards/hemocentro_card.dart';
import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/components/cards/lembrete_card.dart';
import 'package:doe_mais/components/utils/responsive_row_min.dart';
import 'package:doe_mais/models/doacao.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/doacao_dao.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class Perfil extends StatefulWidget {
  @override
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  Doacao doacao;

  Widget _requisitosCard(BuildContext context) {
    return ConfirmationCard(
      title: 'Requisitos para a doação de sangue',
      description: 'Entenda as recomendações necessárias para doar sangue',
      icon: Image.asset('assets/images/icon_test.png'),
      confirmWidget: CustomElevatedButton(
        label: 'Ver requisitos',
        onPressed: () => Navigator.of(context).pushNamed('/requisitos-doacao'),
      ),
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
              FutureBuilder<Doacao>(
                future: DoacaoDao.getDoacaoUser(SessionManager.currentUser),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    doacao = snapshot.data;
                    return LembreteCard(
                      doacao: doacao,
                      onModify: (_doacao) => setState(() => doacao = _doacao),
                    );
                  } else
                    return CircularProgressIndicator();
                },
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 15),
            child: Text(
              'Hemocentros perto de você',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          FutureBuilder<List<Hemocentro>>(
              future: HemocentroDao.getHemocentros(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return CircularProgressIndicator();
                return ResponsiveRowMin(
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  columnWidth: ColumnWidth(
                    smDown: 12,
                    md: 6,
                    lgUp: 4,
                  ),
                  children: snapshot.data
                      .where(
                          (e) => e.cidade == SessionManager.currentUser.cidade)
                      .map((e) => HemocentroCard(e))
                      .toList(),
                );
              }),
        ],
      ),
    );
  }
}
