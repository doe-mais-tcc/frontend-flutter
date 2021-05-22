import 'package:doe_mais/components/general/bullet_point_text.dart';
import 'package:doe_mais/utils/score_manager.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ScoreCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        'assets/images/game_badge.png',
                        height: 70,
                      ),
                      Transform(
                        transform: Matrix4.rotationY(pi),
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: 90,
                          width: 90,
                          child: CircularProgressIndicator(
                            backgroundColor: Colors.grey[400],
                            valueColor: AlwaysStoppedAnimation<Color>(
                                theme.primaryColor),
                            value: ScoreManager.percentage,
                            strokeWidth: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: RichText(
                    softWrap: true,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Seu nível de contribuição é ',
                          style: theme.textTheme.headline1,
                        ),
                        TextSpan(
                          text: '${ScoreManager.level}\n\n',
                          style: TextStyle(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                        ),
                        TextSpan(
                          text: 'Pontos para passar de nível: ',
                          style: theme.textTheme.headline2,
                        ),
                        TextSpan(
                          text: '${ScoreManager.points} / 10\n\n',
                          style: theme.textTheme.headline2
                              .copyWith(color: theme.primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Text('Faça missões para ajudar pessoas e ganhar pontos!\n',
                style: theme.textTheme.headline3),
            SizedBox(height: 20),
            FutureBuilder<List<String>>(
              future: ScoreManager.getMisisons(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return SizedBox();

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    4,
                    (i) => BulletPointText(snapshot.data[i]),
                  ).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
