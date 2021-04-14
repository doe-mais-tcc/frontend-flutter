import 'package:doe_mais/components/hemocentro_card.dart';
import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Hemocentro> hemocentros = [];
  bool showAllHemocentros = false;

  @override
  void initState() {
    super.initState();
    HemocentroDao.getHemocentros().then(
      (list) => setState(() => hemocentros = list),
    );
  }

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
                onPressed: () => SessionManager.currentUser != null
                    ? setState(() => showAllHemocentros = !showAllHemocentros)
                    : null,
              ),
            ],
          ),
          Builder(
            builder: (context) {
              List<Hemocentro> list;
              if (SessionManager.currentUser != null && !showAllHemocentros)
                list = hemocentros
                    .where((e) => e.cidade == SessionManager.currentUser.cidade)
                    .toList();
              else
                list = hemocentros;

              return ResponsiveRow(
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: list
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
