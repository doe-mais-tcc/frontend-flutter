import 'package:doe_mais/components/card_header.dart';
import 'package:doe_mais/components/share_button.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/utils/navigation.dart';
import 'package:doe_mais/utils/sharer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class CampanhaCard extends StatelessWidget {
  final Campanha campanha;
  CampanhaCard(this.campanha);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final shareBtnQty =
        kIsWeb ? SocialMedia.values.length - 1 : SocialMedia.values.length;

    return InkWell(
      hoverColor: Colors.transparent,
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
                  campanha.compartilhavel
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(top: 15, bottom: 10),
                              child: Text('Compartilhe:',
                                  style: theme.textTheme.caption),
                            ),
                            Wrap(
                              alignment: WrapAlignment.center,
                              spacing: 20,
                              children: List.generate(
                                  shareBtnQty,
                                  (i) => ShareButton(
                                        socialMedia: SocialMedia.values[i],
                                        campanha: campanha,
                                      )),
                            ),
                          ],
                        )
                      : Container(),
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
