import 'package:doe_mais/components/custom_outlined_button.dart';
import 'package:doe_mais/models/campanha.dart';
import 'package:doe_mais/utils/sharer.dart';
import 'package:flutter/material.dart';

class CampanhaCard extends StatelessWidget {
  final Campanha campanha;
  CampanhaCard(this.campanha);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: 150),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Container(color: Colors.grey),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${campanha.nomeInternado}',
                  style: Theme.of(context).textTheme.headline2,
                ),
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        '${campanha.hemocentro.endereco}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    Icon(Icons.invert_colors),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Tipo sanguíneo: ${campanha.tipoSanguineo}',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ],
                ),
                campanha.compartilhavel
                    ? Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: CustomOutlinedButton(
                          label: 'Compartilhe no Facebook',
                          onPressed: () {},
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
