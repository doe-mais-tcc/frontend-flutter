import 'package:doe_mais/components/carousel_controls.dart';
import 'package:doe_mais/components/hemocentro_card.dart';
import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/message_card.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:responsively/responsively.dart';

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  List<Hemocentro> hemocentros = [];
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
    HemocentroDao.getHemocentros()
        .then(
          (list) => setState(() => hemocentros = list),
        )
        .onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 0,
      child: Column(
        children: [
          Text('Bem Vindo!', style: Theme.of(context).textTheme.headline1),
          SizedBox(height: 30),
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
              SessionManager.currentUser != null
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: TextButton(
                        child: Text(
                            showAllHemocentros ? '(ver menos)' : '(ver todos)'),
                        onPressed: () => SessionManager.currentUser != null
                            ? setState(
                                () => showAllHemocentros = !showAllHemocentros)
                            : null,
                      ),
                    )
                  : Container(),
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
              if (list == null) return CircularProgressIndicator();
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
