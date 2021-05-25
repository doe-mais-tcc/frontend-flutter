import 'dart:convert';
import 'package:doe_mais/components/cards/hemocentro_card.dart';
import 'package:doe_mais/components/cards/message_card.dart';
import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/components/general/custom_carousel.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:doe_mais/services/hemocentro_dao.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:responsively/responsively.dart';
import 'package:doe_mais/utils/navigation.dart' show Pages;

class Inicio extends StatefulWidget {
  @override
  _InicioState createState() => _InicioState();
}

class _InicioState extends State<Inicio> {
  final carouselControl = CarouselController();
  List<Widget> messages = [];
  bool showAllHemocentros = false;
  int carouselIndex = 0;

  void getCarouselData() async {
    String json =
        await rootBundle.loadString('assets/files/carousel_messages.json');
    var list = jsonDecode(json) as List;
    setState(() {
      messages = list
          .map((e) => MessageCard(
                (e as Map<String, dynamic>),
              ))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    getCarouselData();
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
          CustomCarousel(
            carouselController: carouselControl,
            height: 250,
            child: CarouselSlider(
              items: messages,
              carouselController: carouselControl,
              options: CarouselOptions(
                height: 250,
                autoPlay: true,
                enlargeCenterPage: true,
                autoPlayInterval: const Duration(seconds: 4),
                onPageChanged: (i, _) => setState(() => carouselIndex = i),
              ),
            ),
          ),
          DotsIndicator(
            dotsCount: messages.length == 0 ? 1 : messages.length,
            position: (carouselIndex ?? 0).toDouble(),
          ),
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
