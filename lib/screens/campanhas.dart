import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/campanha_card.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class Campanhas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 3,
      child: Column(
        children: [
          Text('Campanhas', style: Theme.of(context).textTheme.headline1),
          SessionManager.currentUser != null
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Suas Campanhas',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        CustomElevatedButton(
                          label: 'Criar uma campanha',
                          onPressed: () => Navigator.of(context)
                              .pushNamed('/campanhas/criar'),
                        ),
                      ],
                    ),
                    FutureBuilder<List<Campanha>>(
                      future: CampanhaDao.getCampanhasUsuario(
                          SessionManager.currentUser),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.hasData)
                            return ResponsiveRow(
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              children: snapshot.data
                                  .map(
                                    (e) => ResponsiveColumn(
                                      width: ColumnWidth(
                                        smDown: 12,
                                        md: 6,
                                        lgUp: 4,
                                      ),
                                      child: CampanhaCard(e),
                                    ),
                                  )
                                  .toList(),
                            );
                          return Text('Você não tem nenhuma campanha ainda');
                        }
                        return CircularProgressIndicator();
                      },
                    )
                  ],
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.only(top: 40, bottom: 5),
            child: Text(
              'Campanhas para ajudar',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          FutureBuilder<List<Campanha>>(
            future: CampanhaDao.getCampanhas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return CircularProgressIndicator();
              if (!snapshot.hasData) return Text('Nenhuma campanha encontrada');

              return ResponsiveRow(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: snapshot.data
                    .map(
                      (e) => ResponsiveColumn(
                        width: ColumnWidth(
                          smDown: 12,
                          md: 6,
                          lgUp: 4,
                        ),
                        child: CampanhaCard(e),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
