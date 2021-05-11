import 'package:doe_mais/utils/custom_theme.dart';
import 'package:flutter/material.dart';

class FormFrame extends StatelessWidget {
  final List<Widget> children;
  final String title;
  final GlobalKey formKey;
  FormFrame({@required this.children, this.title, this.formKey});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 600),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  '*obrigatório',
                  style: CustomTheme.errorText(context),
                ),
                Text(
                  '$title',
                  style: Theme.of(context).textTheme.headline2,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            Column(
              children: children,
            ),
          ],
        ),
      ),
    );
  }
}
