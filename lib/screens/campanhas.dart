import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:doe_mais/components/buttons/custom_elevated_button.dart';
import 'package:doe_mais/components/cards/campanha_card.dart';
import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/services/campanha_dao.dart';
import 'package:doe_mais/utils/navigation.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';
import 'package:responsively/responsively.dart';
import 'package:doe_mais/utils/navigation.dart' show Pages;

class Campanhas extends StatefulWidget {
  @override
  _CampanhasState createState() => _CampanhasState();
}

class _CampanhasState extends State<Campanhas> {
  final carouselController = CarouselController();
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
                    SizedBox(height: 20),
                    campanhasUser.isEmpty
                        ? Container()
                        : SizedBox(
                            height: 350,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: campanhasUser.length,
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: CampanhaCard(
                                  campanhasUser[index],
                                ),
                              ),
                            ),
                          ),
                  ],
                )
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Campanhas para ajudar',
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
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
