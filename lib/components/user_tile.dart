import 'package:doe_mais/utils/custom_theme.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class UserTile extends StatelessWidget {
  final Function onConfirm;
  UserTile({this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return SessionManager.currentUser != null
        ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Bem vindo(a), ${SessionManager.currentUser.nome}'),
              TextButton(
                child: Text('Sair'),
                onPressed: () {
                  SessionManager.endSession();
                  onConfirm();
                },
              ),
            ],
          )
        : TextButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Entrar na conta',
                    style: CustomTheme.activeHamburger(context),
                  ),
                  Icon(Icons.person, color: Theme.of(context).accentColor),
                ],
              ),
            ),
            onPressed: () => Navigator.of(context).pushNamed('/login'),
            style: TextButton.styleFrom(
              primary: Theme.of(context).primaryColor,
            ),
          );
  }
}
