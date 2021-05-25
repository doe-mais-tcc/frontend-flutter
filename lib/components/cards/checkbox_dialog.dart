import 'package:flutter/material.dart';
import 'package:doe_mais/components/buttons/custom_elevated_button.dart';

class BloodDialog extends StatefulWidget {
  @override
  _BloodDialogState createState() => _BloodDialogState();
}

class _BloodDialogState extends State<BloodDialog> {
  final _bloodTypes = ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
  List<bool> checked;
  int half;

  void _returnValue(BuildContext context) {
    List<String> text = [];

    for (int i = 0; i < _bloodTypes.length; i++)
      if (checked[i]) text.add(_bloodTypes[i]);

    Navigator.of(context).pop(text.join(', '));
  }

  @override
  void initState() {
    checked = List.filled(_bloodTypes.length, true);
    half = _bloodTypes.length ~/ 2;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Dialog(
          child: Container(
            padding: const EdgeInsets.all(30),
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Selecione os tipos sanguíneos para doar:',
                  textAlign: TextAlign.center,
                  softWrap: true,
                  style: Theme.of(context).textTheme.headline1,
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 300),
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  child: Wrap(
                    children: List.generate(
                      _bloodTypes.length,
                      (i) => SizedBox(
                        width: 200,
                        child: CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(_bloodTypes[i]),
                          value: checked[i],
                          onChanged: (value) =>
                              setState(() => checked[i] = value),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        child: Text('Cancelar'),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ),
                    Expanded(
                      child: CustomElevatedButton(
                        label: 'Selecionar',
                        onPressed: () => _returnValue(context),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
