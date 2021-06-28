import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:doe_mais/utils/confirm_dialog.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class ProfilePanel extends StatefulWidget {
  final User user;
  ProfilePanel(this.user);

  @override
  _ProfilePanelState createState() => _ProfilePanelState();
}

class _ProfilePanelState extends State<ProfilePanel> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(360),
              child: Container(
                height: 100,
                width: 100,
                color: Colors.grey[350],
                padding: const EdgeInsets.only(top: 20),
                child: Image.asset(
                  'assets/images/avatar_${widget.user.sexo}.png',
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    text: widget.user.nome,
                    style: theme.textTheme.headline2
                        .copyWith(color: theme.primaryColor),
                  ),
                  softWrap: true,
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
                SelectableText(
                  widget.user.cidade,
                  style: theme.textTheme.headline4,
                ),
                SelectableText(
                  'Sangue ' + widget.user.sangue,
                  style: theme.textTheme.headline4,
                ),
              ],
            ),
          ],
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
              child: Text('Editar Perfil'),
              onPressed: () =>
                  Navigator.of(context).pushNamed('/perfil/editar-perfil'),
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
                  UserDao.deleteUser(widget.user);
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
