import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:doe_mais/utils/confirm_dialog.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class ProfilePanel extends StatelessWidget {
  final User user;
  ProfilePanel(this.user);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          Icons.account_circle,
          size: 100,
          color: theme.disabledColor,
        ),
        SizedBox(width: 20),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SelectableText(
              user.nome,
              style:
                  theme.textTheme.headline2.copyWith(color: theme.primaryColor),
            ),
            SelectableText(
              user.cidade,
              style: theme.textTheme.headline4,
            ),
            SelectableText(
              'Sangue ' + user.sangue,
              style: theme.textTheme.headline4,
            ),
          ],
        ),
        Spacer(),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: Text('Editar Perfil'),
              onPressed: () {},
            ),
            TextButton(
              child: Text('Excluir Conta'),
              onPressed: () async {
                bool action = await confirmDialog(
                  context: context,
                  message:
                      'Tem certeza que deseja excluir sua conta? Essa ação é irreversível',
                  yesLabel: 'Excluir',
                  noLabel: 'Cancelar',
                );
                if (action) {
                  UserDao.deleteUser(user);
                  Navigator.of(context).pushNamed('/inicio');
                }
              },
            ),
            TextButton(
              child: Text('Sair'),
              onPressed: () {
                SessionManager.endSession();
                Navigator.of(context).pushNamed('/inicio');
              },
            ),
          ],
        ),
      ],
    );
  }
}
