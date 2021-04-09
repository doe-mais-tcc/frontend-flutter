import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/hemocentro_card.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class CampanhaInfo extends StatelessWidget {
  final Campanha campanha;
  CampanhaInfo(this.campanha);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return AppFrame(
      menuIndex: 3,
      child: Column(
        children: [
          Text(
            'Campanha de ${campanha.nomeInternado}',
            style: theme.textTheme.headline1,
          ),
          SizedBox(height: 40),
          ResponsiveRow(
            mainAxisSpacing: 20,
            crossAxisSpacing: 10,
            children: [
              ResponsiveColumn(
                width: ColumnWidth(
                  smDown: 12,
                  md: 12,
                  lgUp: 8,
                ),
                child: card1(theme),
              ),
              ResponsiveColumn(
                width: ColumnWidth(
                  smDown: 12,
                  md: 12,
                  lgUp: 4,
                ),
                child: card2(theme),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column card1(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Sobre a campanha',
          style: theme.textTheme.headline1,
        ),
        SizedBox(height: 20),
        Card(
          child: Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Text('Campanha criada por ${campanha.user.nome}'),
                  SizedBox(height: 30),
                  Wrap(
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    runSpacing: 10,
                    children: [
                      Icon(
                        Icons.invert_colors,
                        color: theme.primaryColor,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Tipo sanguíneo preferencial: ',
                        style: theme.textTheme.headline2,
                      ),
                      Text(
                        '${campanha.tipoSanguineo}',
                        style: theme.textTheme.bodyText2
                            .copyWith(color: theme.accentColor),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40, bottom: 20),
                    child: Text(
                      'Sobre:',
                      style: theme.textTheme.headline2,
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 100),
                    child: Text(
                      '${campanha.descricao}',
                      style: theme.textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Column card2(ThemeData theme) {
    return Column(
      children: [
        Text(
          'Essa pessoa está internada aqui',
          style: theme.textTheme.headline1,
        ),
        SizedBox(height: 20),
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 500),
          child: HemocentroCard(campanha.hemocentro),
        ),
      ],
    );
  }
}
