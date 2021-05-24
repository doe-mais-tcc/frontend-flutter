import 'package:doe_mais/components/buttons/custom_back_button.dart';
import 'package:doe_mais/components/utils/form_step.dart';
import 'package:doe_mais/components/utils/form_stepper.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/screens/form_pages/user_form_step1.dart';
import 'package:doe_mais/screens/form_pages/user_form_step2.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class UserForm extends StatelessWidget {
  final User editUser;
  UserForm(this.editUser);

  @override
  Widget build(BuildContext context) {
    final List<FormStep> steps = editUser == null
        ? [UserFormStep1(null), UserFormStep2()]
        : [UserFormStep1(editUser)];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: CustomBackButton(),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                constraints: BoxConstraints(maxWidth: 600),
                padding:
                    const EdgeInsets.only(left: 50, right: 50, bottom: 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      width: 80,
                    ),
                    Text(
                      editUser == null
                          ? 'Cadastro de usuário'
                          : 'Edite seu perfil',
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    SizedBox(height: 20),
                    FormStepper(
                      steps: steps,
                      onSubmit: (data) {
                        var user = User.fromJson(data);

                        if (editUser == null)
                          UserDao.postUser(user).then(
                            (response) {
                              SessionManager.createSession(response, false);
                              Navigator.of(context).pushNamed('/inicio');
                            },
                          ).onError((error, stackTrace) {
                            alertBottomSheet(
                              context: context,
                              message: 'Não foi possível concluir o cadastro',
                            );
                          });
                        else {
                          editUser.inject(user);
                          UserDao.updateUser(editUser).then(
                            (response) {
                              Navigator.of(context).pushNamed('/perfil');
                            },
                          ).onError((error, stackTrace) {
                            alertBottomSheet(
                              context: context,
                              message: 'Não foi possível editar o perfil',
                            );
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
