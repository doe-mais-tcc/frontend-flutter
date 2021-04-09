import 'package:doe_mais/components/hemocentro_card.dart';
import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 0,
      child: Column(
        children: [
          Text('Bem Vindo!', style: Theme.of(context).textTheme.headline1),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).accentColor,
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            height: 400,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Faça o Teste!',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'lorem',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Wrap(
            spacing: 10,
            children: [
              Text(
                'Hemocentros próximos',
                style: Theme.of(context).textTheme.headline2,
              ),
              TextButton(
                child: Text('(ver todos)'),
                onPressed: () {},
              ),
            ],
          ),
          FutureBuilder<List<Hemocentro>>(
            future: HemocentroDao.getHemocentros(),
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done)
                return Center(child: CircularProgressIndicator());
              if (!snapshot.hasData)
                return Text('Não foi possível carregar Hemocentros');
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
                        child: HemocentroCard(e),
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
