import 'package:doe_mais/components/custom_elevated_button.dart';
import 'package:doe_mais/components/custom_outlined_button.dart';
import 'package:doe_mais/components/form_step.dart';
import 'package:doe_mais/utils/themed_steps_indicator.dart';
import 'package:flutter/material.dart';

class FormStepper extends StatefulWidget {
  final List<FormStep> steps;
  final Function(Map<String, dynamic>) onSubmit;
  FormStepper({@required this.steps, @required this.onSubmit});

  @override
  _FormStepperState createState() => _FormStepperState();
}

class _FormStepperState extends State<FormStepper> {
  int currentStep = 0;
  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        themedStepsIndicator(
          context: context,
          nbSteps: widget.steps.length,
          selectedStep: currentStep,
          lineLength: 180,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: widget.steps[currentStep],
        ),
        Row(
          children: [
            Expanded(
              child: currentStep > 0
                  ? CustomOutlinedButton(
                      label: 'Anterior',
                      leftIcon: Icon(Icons.chevron_left_outlined),
                      onPressed: () => setState(() => currentStep--),
                    )
                  : CustomOutlinedButton(
                      label: 'Cancelar',
                      onPressed: () => Navigator.of(context).pop(),
                    ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: currentStep + 1 < widget.steps.length
                  ? CustomElevatedButton(
                      label: 'Próximo',
                      rightIcon: Icon(Icons.chevron_right_outlined),
                      onPressed: () {
                        if (widget.steps[currentStep].validate())
                          setState(() => currentStep++);
                      },
                    )
                  : CustomElevatedButton(
                      label: 'Concluir',
                      onPressed: () {
                        if (widget.steps[currentStep].validate()) {
                          for (FormStep step in widget.steps)
                            data.addAll(step.returnData());
                          widget.onSubmit(data);
                        }
                      },
                    ),
            ),
          ],
        ),
      ],
    );
  }
}
