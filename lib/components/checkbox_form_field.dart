import 'package:flutter/material.dart';

class CheckboxFormField extends FormField<bool> {
  CheckboxFormField({
    Widget title,
    FormFieldSetter<bool> onSaved,
    FormFieldValidator<bool> validator,
    bool initialValue = false,
    AutovalidateMode autovalidatemode = AutovalidateMode.onUserInteraction,
  }) : super(
          onSaved: onSaved,
          validator: validator,
          initialValue: initialValue,
          autovalidateMode: autovalidatemode,
          builder: (FormFieldState<bool> state) {
            return ListTile(
              dense: state.hasError,
              leading: Checkbox(
                value: state.value,
                onChanged: state.didChange,
              ),
              title: title,
              subtitle: state.hasError
                  ? Builder(
                      builder: (BuildContext context) => Text(
                        state.errorText,
                        style: TextStyle(color: Theme.of(context).errorColor),
                      ),
                    )
                  : Container(),
            );
          },
        );
}
