import 'package:doe_mais/components/cards/card_header.dart';
import 'package:doe_mais/components/buttons/share_button.dart';
import 'package:doe_mais/components/general/campanha_popup_menu.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/utils/navigation.dart';
import 'package:doe_mais/utils/sharer.dart';
import 'package:flutter/material.dart';

class CampanhaCard extends StatelessWidget {
  final Campanha campanha;
  final bool editable;
  CampanhaCard(this.campanha, {this.editable = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        InkWell(
          hoverColor: Colors.transparent,
          child: SizedBox(
            width: 380,
            child: Card(
              margin: const EdgeInsets.only(bottom: 15),
              child: Column(
                children: [
                  CardHeader(
                    height: 100,
                    imageUrl: campanha.hemocentro.url,
                    applyBlur: true,
                  ),
                  Stack(
                    children: [
                      if (editable)
                        Align(
                          alignment: Alignment.topRight,
                          child: CampanhaPopupMenu(campanha),
                        ),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '${campanha.nomeInternado}',
                              style: theme.textTheme.headline2,
                              textAlign: TextAlign.center,
                              softWrap: true,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
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
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 10),
                                        child: Text('Compartilhe:',
                                            style: theme.textTheme.caption),
                                      ),
                                      Wrap(
                                        alignment: WrapAlignment.center,
                                        spacing: 20,
                                        children: SocialMedia.values
                                            .map((e) => ShareButton(
                                                  socialMedia: e,
                                                  campanha: campanha,
                                                ))
                                            .toList(),
                                      ),
                                    ],
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          onTap: () => Navigator.of(context)
              .pushNamed(Navigation.getCampanhaRoute(campanha)),
        ),
      ],
    );
  }
}
