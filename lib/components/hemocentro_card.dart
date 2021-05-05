import 'package:doe_mais/components/card_header.dart';
import 'package:doe_mais/components/source_box.dart';
import 'package:doe_mais/models/hemocentro.dart';
import 'package:flutter/material.dart';

class HemocentroCard extends StatefulWidget {
  final Hemocentro hemocentro;
  HemocentroCard(this.hemocentro) : assert(hemocentro != null);

  @override
  _HemocentroCardState createState() => _HemocentroCardState();
}

class _HemocentroCardState extends State<HemocentroCard> {
  bool showSource = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          MouseRegion(
            onEnter: (_) => setState(() => showSource = true),
            onExit: (_) => setState(() => showSource = false),
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                CardHeader(
                  height: 200,
                  imageUrl: widget.hemocentro.url,
                ),
                showSource
                    ? SourceBox(sourceLink: widget.hemocentro.url)
                    : Container(),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${widget.hemocentro.nome}',
                  style: Theme.of(context).textTheme.headline3,
                ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Icon(Icons.location_city),
                    SizedBox(width: 8),
                    Text(
                      '${widget.hemocentro.cidade}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${widget.hemocentro.endereco}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
