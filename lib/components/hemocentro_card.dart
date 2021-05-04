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
  final Widget _loadingWidget = Container(
    color: Colors.black26,
    child: Center(child: CircularProgressIndicator()),
  );
  bool showSource = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 3,
            child: MouseRegion(
              onEnter: (_) => setState(() => showSource = true),
              onExit: (_) => setState(() => showSource = false),
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  AspectRatio(
                    aspectRatio: 1.8,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: widget.hemocentro.url == null
                          ? _loadingWidget
                          : Image.network(
                              widget.hemocentro.url,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) =>
                                  progress != null ? _loadingWidget : child,
                            ),
                    ),
                  ),
                  showSource
                      ? SourceBox(sourceLink: widget.hemocentro.url)
                      : Container(),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${widget.hemocentro.nome}',
                    style: Theme.of(context).textTheme.headline3,
                  ),
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
          ),
        ],
      ),
    );
  }
}
