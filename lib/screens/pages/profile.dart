import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      children: [
        Text('Este é seu perfil!',
            style: Theme.of(context).textTheme.headline1),
      ],
    );
  }
}
