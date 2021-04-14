import 'package:doe_mais/models/hemocentro.dart';
import 'package:flutter/material.dart';

class HemocentroCard extends StatelessWidget {
  final Hemocentro hemocentro;
  HemocentroCard(this.hemocentro);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            flex: 3,
            child: AspectRatio(
              aspectRatio: 1.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(hemocentro.url, fit: BoxFit.cover),
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
                    hemocentro.nome,
                    style: Theme.of(context).textTheme.headline3,
                  ),
                  Row(
                    children: [
                      Icon(Icons.location_city),
                      SizedBox(width: 8),
                      Text(
                        hemocentro.cidade,
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
                          hemocentro.endereco,
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
