import 'dart:ui';

import 'package:doe_mais/components/card_header.dart';
import 'package:doe_mais/components/share_button.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/utils/navigation.dart';
import 'package:doe_mais/utils/sharer.dart';
import 'package:flutter/material.dart';

class CampanhaCard extends StatelessWidget {
  final Campanha campanha;
  CampanhaCard(this.campanha);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CardHeader(
              height: 100,
              imageUrl: campanha.hemocentro.url,
              applyBlur: true,
            ),
            Container(
              height: 220,
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${campanha.nomeInternado}',
                    style: theme.textTheme.headline2,
                  ),
                  SizedBox(height: 10),
                  Row(
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
                  SizedBox(height: 15),
                  Text('Compartilhe:', style: theme.textTheme.caption),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: SocialMedia.values
                        .map((e) =>
                            ShareButton(socialMedia: e, campanha: campanha))
                        .toList(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      onTap: () => Navigator.of(context)
          .pushNamed(Navigation.getCampanhaRoute(campanha)),
    );
  }
}
