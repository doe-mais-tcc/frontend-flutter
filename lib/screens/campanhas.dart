import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/campanha_card.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class Campanhas extends StatefulWidget {
  @override
  _CampanhasState createState() => _CampanhasState();
}

class _CampanhasState extends State<Campanhas> {
  List<Campanha> campanhas = [];

  @override
  void initState() {
    super.initState();
    CampanhaDao.getCampanhas().then(
      (list) => setState(() => campanhas = list),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 3,
      child: Column(
        children: [
          Text('Campanhas', style: Theme.of(context).textTheme.headline1),
          campanhas.isEmpty
              ? CircularProgressIndicator()
              : SessionManager.currentUser != null
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
                        ResponsiveRow(
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          children: campanhas
                              .where(
                                (e) =>
                                    e.user.id == SessionManager.currentUser.id,
                              )
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
                        ),
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
          ResponsiveRow(
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: campanhas
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
          ),
        ],
      ),
    );
  }
}
