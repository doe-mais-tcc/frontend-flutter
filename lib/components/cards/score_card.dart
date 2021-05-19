import 'package:doe_mais/components/general/bullet_point_text.dart';
import 'package:doe_mais/models/user.dart';
import 'package:flutter/material.dart';
import 'dart:math' show pi;

class ScoreCard extends StatelessWidget {
  final User user;
  ScoreCard(this.user);

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
                            value: user.pontuacao % 10 / 10,
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
                          text: '${user.pontuacao % 10}\n\n',
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
                          text: '${user.pontuacao % 10} / 10\n\n',
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
            BulletPointText('Compartilhe uma campanha no Facebook'),
            BulletPointText(
                'Crie uma campanha para alguem que necessita de sangue'),
            BulletPointText('Crie um lembrete para uma doação de sangue'),
            BulletPointText('Compartilhe uma campanha no Whatsapp'),
          ],
        ),
      ),
    );
  }
}
