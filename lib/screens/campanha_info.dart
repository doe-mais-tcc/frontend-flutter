import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/hemocentro_card.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:flutter/material.dart';

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
          Container(
            constraints: BoxConstraints(maxWidth: 800),
            child: Column(
              children: [
                Text(
                  'Campanha de ${campanha.nomeInternado}',
                  style: theme.textTheme.headline1,
                ),
                SizedBox(height: 30),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 30, 10, 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.location_on),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                '${campanha.hemocentro.endereco}',
                                style: theme.textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.invert_colors),
                            SizedBox(width: 8),
                            Flexible(
                              child: Text(
                                'Tipo sanguíneo: ${campanha.tipoSanguineo}',
                                style: theme.textTheme.bodyText1,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 40, bottom: 20),
                          child: Text(
                            'Sobre a campanha',
                            style: theme.textTheme.headline1,
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
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 10),
                  child: Text(
                    'Essa pessoa está internada aqui',
                    style: theme.textTheme.headline1,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 400),
                  child: HemocentroCard(campanha.hemocentro),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
