import 'package:doe_mais/components/app_frame.dart';
import 'package:doe_mais/components/form_step.dart';
import 'package:doe_mais/components/form_stepper.dart';
import 'package:doe_mais/models/user.dart';
import 'package:doe_mais/screens/signup_steps/signup_step1.dart';
import 'package:doe_mais/screens/signup_steps/signup_step2.dart';
import 'package:doe_mais/services/user_dao.dart';
import 'package:doe_mais/utils/custom_bottom_sheet.dart';
import 'package:doe_mais/utils/session_manager.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  final List<FormStep> steps = [
    SignupStep1(),
    SignupStep2(),
  ];

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      child: Column(
        children: [
          Text(
            'Cadastro de usuário',
            style: Theme.of(context).textTheme.headline1,
          ),
          SizedBox(height: 20),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: FormStepper(
              steps: steps,
              onSubmit: (data) {
                var user = User.fromJson(data);
                UserDao.postUser(user).then((value) {
                  SessionManager.saveSession(user);
                  Navigator.of(context).pushNamed('/home');
                }).onError(
                  (error, stackTrace) {
                    alertBottomSheet(
                        context: context,
                        message: 'Não foi possível concluir o cadastro');
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
