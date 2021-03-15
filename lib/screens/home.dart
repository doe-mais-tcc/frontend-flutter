import 'package:doe_mais/components/hamburger_menu.dart';
import 'package:doe_mais/components/hospital_card.dart';
import 'package:doe_mais/models/hospital.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Home extends StatelessWidget {
  final Hospital hospital = Hospital(
      name: 'Hemocentro', location: 'Endereço', phone: '(13) 99999-9999');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: SvgPicture.asset('assets/images/logo.svg')),
      drawer: HamburgerMenu(currentIndex: 0),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        children: [
          Text('Bem Vindo!', style: Theme.of(context).textTheme.headline1),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Theme.of(context).accentColor,
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 25),
            height: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Faça o Teste!',
                  style: Theme.of(context)
                      .textTheme
                      .headline2
                      .copyWith(color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  'lorem',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      .copyWith(color: Colors.white),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Text(
                'Hemocentros próximos',
                style: Theme.of(context).textTheme.headline2,
              ),
              TextButton(
                child: Text('(ver todos)'),
                onPressed: () {},
              ),
            ],
          ),
          HospitalCard(hospital),
        ],
      ),
    );
  }
}
