import 'package:doe_mais/components/custom_outlined_button.dart';
import 'package:doe_mais/models/campanha.dart';
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
                  '${campanha.nome}',
                  style: Theme.of(context).textTheme.headline3,
                ),
                Row(
                  children: [
                    Icon(Icons.location_on),
                    SizedBox(width: 8),
                    Text(
                      '${campanha.cidade}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.invert_colors),
                    SizedBox(width: 8),
                    Text(
                      'Tipo preferencial: ${campanha.idHemocentro ?? 'Qualquer'}',
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ],
                ),
                SizedBox(height: 10),
                CustomOutlinedButton(
                  label: 'Compartilhe no Facebook',
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
