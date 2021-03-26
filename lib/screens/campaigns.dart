import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/campanha_card.dart';
import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/screens/campaign_form.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class Campaigns extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 3,
      child: Column(
        children: [
          Text('Campanhas', style: Theme.of(context).textTheme.headline1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Suas Campanhas',
                style: Theme.of(context).textTheme.headline2,
              ),
              CustomElevatedButton(
                label: 'Criar uma campanha',
                onPressed: () =>
                    Navigator.of(context).pushNamed('/campanhas/criar'),
              ),
            ],
          ),
          FutureBuilder<List<Campanha>>(
            future: CampanhaDao.getCampanhas(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(child: CircularProgressIndicator());
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
