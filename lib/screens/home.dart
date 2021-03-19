import 'package:doe_mais/components/hospital_card.dart';
import 'package:doe_mais/models/hospital.dart';
import 'package:doe_mais/components/app_frame.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final Hospital hospital = Hospital(
      name: 'Hemocentro', location: 'Endereço', phone: '(13) 99999-9999');

  @override
  Widget build(BuildContext context) {
    return AppFrame(
      menuIndex: 0,
      child: ListView(
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
          Wrap(
            spacing: 10,
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
          LayoutBuilder(
            builder: (context, constraints) {
              int columns;
              if (constraints.maxWidth > 1000)
                columns = 3;
              else if (constraints.maxWidth > 600)
                columns = 2;
              else
                columns = 1;

              return GridView.count(
                shrinkWrap: true,
                crossAxisCount: columns,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  HospitalCard(hospital),
                  HospitalCard(hospital),
                  HospitalCard(hospital),
                  HospitalCard(hospital),
                  HospitalCard(hospital),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
