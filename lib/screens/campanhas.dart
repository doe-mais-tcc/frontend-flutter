import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/components/cards/campanha_card.dart';
import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/components/buttons/carousel_controls.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/utils/navigation.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:doe_mais/utils/navigation.dart' show Pages;

class Campanhas extends StatefulWidget {
  @override
  _CampanhasState createState() => _CampanhasState();
}

class _CampanhasState extends State<Campanhas> {
  List<Campanha> campanhas = [];
  List<Campanha> campanhasUser = [];

  @override
  void initState() {
    super.initState();

    CampanhaDao.getCampanhas()
        .then(
          (list) => setState(() {
            if (list == null) return;
            campanhas = list;
            if (SessionManager.isLogged)
              campanhasUser = campanhas
                  .where((e) => e.user.id == SessionManager.currentUser.id)
                  .toList();
          }),
        )
        .onError((error, stackTrace) => null);
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      page: Pages.Campanhas,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child:
                Text('Campanhas', style: Theme.of(context).textTheme.headline1),
          ),
          SessionManager.isLogged
              ? Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Suas Campanhas',
                          style: Theme.of(context).textTheme.headline2,
                        ),
                        Spacer(),
                        SizedBox(
                          width: 200,
                          child: CustomElevatedButton(
                            label: 'Criar uma campanha',
                            onPressed: () => Navigator.of(context)
                                .pushNamed('/campanhas/criar'),
                          ),
                        ),
                      ],
                    ),
                    campanhasUser.isEmpty
                        ? Container()
                        : CarouselControls(
                            height: 420,
                            infiniteCarousel: InfiniteCarousel.builder(
                              controller: InfiniteScrollController(),
                              itemCount: campanhasUser.length,
                              itemExtent: 400,
                              center: false,
                              loop: false,
                              itemBuilder: (_, index, __) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                child: CampanhaCard(campanhasUser[index]),
                              ),
                            ),
                          ),
                  ],
                )
              : Container(),
          Text(
            'Campanhas para ajudar',
            style: Theme.of(context).textTheme.headline2,
          ),
          SizedBox(height: 10),
          campanhas.isEmpty
              ? CircularProgressIndicator()
              : ResponsiveRow(
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
