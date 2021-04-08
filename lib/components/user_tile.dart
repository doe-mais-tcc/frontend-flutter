import 'package:doe_mais/components/custom_elevated_button.dart';
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
        : CustomElevatedButton(
            label: 'Entrar',
            onPressed: () => Navigator.of(context).pushNamed('/login'),
          );
  }
}
