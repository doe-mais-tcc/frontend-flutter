import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/utils/custom_theme.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final Function onConfirm;
  UserTile({this.onConfirm});

  @override
  Widget build(BuildContext context) {
    final user = SessionManager.currentUser;
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 200),
      child: user != null
          ? RichText(
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              text: TextSpan(
                  text: 'Bem vind${user.sexo == Sexo.Masculino ? 'o' : 'a'}'
                      '\n${SessionManager.currentUser.nome}'),
            )
          : TextButton(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Entrar na conta',
                      style: CustomTheme.activeHamburger(context),
                    ),
                    Icon(Icons.person,
                        color: Theme.of(context).colorScheme.primary),
                  ],
                ),
              ),
              onPressed: () => Navigator.of(context).pushNamed('/login'),
              style: TextButton.styleFrom(
                primary: Theme.of(context).primaryColor,
              ),
            ),
    );
  }
}
