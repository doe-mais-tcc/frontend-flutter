import 'package:doe_mais/components/form_step.dart';
import 'package:doe_mais/components/form_stepper.dart';
import 'package:doe_mais/screens/signup_steps/signup_step1.dart';
import 'package:doe_mais/screens/signup_steps/signup_step2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SignUp extends StatelessWidget {
  final List<FormStep> steps = [
    SignupStep1(),
    SignupStep2(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 600),
          child: ListView(
            padding: EdgeInsets.symmetric(vertical: 80, horizontal: 40),
            children: [
              SvgPicture.asset(
                'assets/images/logo.svg',
                width: 60,
                semanticsLabel: 'Logo Doe mais',
                alignment: Alignment.centerLeft,
              ),
              Text(
                'Cadastro de usuário',
                style: Theme.of(context).textTheme.headline1,
              ),
              SizedBox(height: 20),
              FormStepper(
                steps: steps,
                onSubmit: (users) => Navigator.of(context).pushNamed('/'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
