import 'dart:convert';
import 'package:doe_mais/components/cards/info_card.dart';
import 'package:doe_mais/components/general/app_frame.dart';
import 'package:doe_mais/models/info.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

class RequisitosDoacao extends StatelessWidget {
  final String referenceUrl =
      'https://portalarquivos.saude.gov.br/campanhas/doesangue/';

  Future<List<Info>> getInfo() async {
    String jsonString =
        await rootBundle.loadString('assets/files/donation_info.json');
    return (jsonDecode(jsonString) as List)
        .map((e) => Info.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Estes são os requisitos mínimos para doar sangue',
              style: Theme.of(context).textTheme.headline1,
              textAlign: TextAlign.center,
            ),
          ),
          FutureBuilder<List<Info>>(
            future: getInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData)
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) =>
                      InfoCard(snapshot.data[index]),
                );

              return Center(child: CircularProgressIndicator());
            },
          ),
          SizedBox(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () => launch(referenceUrl),
                  child: Text('Referência: $referenceUrl'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
