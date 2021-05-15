import 'package:doe_mais/components/cards/hemocentro_card.dart';
import 'package:doe_mais/components/cards/message_card.dart';
import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';
import 'package:doe_mais/utils/navigation.dart' show Pages;

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List<Widget> messages = [];
  bool showAllHemocentros = false;

  @override
  void initState() {
    super.initState();
    messages.add(
      MessageCard(
        title: 'Faça o teste agora!',
        message:
            'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      page: Pages.Inicio,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text('Bem Vindo!',
                style: Theme.of(context).textTheme.headline1),
          ),
          // CarouselControls(
          //   height: 300,
          //   infiniteCarousel: InfiniteCarousel.builder(
          //     controller: InfiniteScrollController(),
          //     itemCount: messages.length,
          //     itemExtent: 500,
          //     itemBuilder: (context, index, _) => Padding(
          //       padding: const EdgeInsets.symmetric(horizontal: 15),
          //       child: messages[index],
          //     ),
          //   ),
          // ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  'Hemocentros próximos',
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
              SessionManager.isLogged
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                        child: Text(
                            showAllHemocentros ? '(ver menos)' : '(ver todos)'),
                        onPressed: () => SessionManager.isLogged
                            ? setState(
                                () => showAllHemocentros = !showAllHemocentros)
                            : null,
                      ),
                    )
                  : Container(),
            ],
          ),
          FutureBuilder(
            future: HemocentroDao.getHemocentros(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return CircularProgressIndicator();

              List<Hemocentro> list = snapshot.data;
              if (SessionManager.isLogged && !showAllHemocentros)
                list = snapshot.data
                    .where((e) => e.cidade == SessionManager.currentUser.cidade)
                    .toList();

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
