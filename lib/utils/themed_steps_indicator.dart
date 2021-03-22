import 'package:flutter/material.dart';
import 'package:steps_indicator/steps_indicator.dart';

StepsIndicator themedStepsIndicator({
  @required BuildContext context,
  @required int nbSteps,
  @required int selectedStep,
  double lineLength,
}) {
  final primaryColor = Theme.of(context).primaryColor;
  final disabledColor = Theme.of(context).disabledColor;

  return StepsIndicator(
    nbSteps: nbSteps,
    selectedStep: selectedStep,
    lineLength: lineLength ?? 40,
    selectedStepColorIn: Colors.white,
    selectedStepColorOut: primaryColor,
    unselectedStepColorIn: Colors.white,
    unselectedStepColorOut: disabledColor,
    doneStepColor: primaryColor,
    doneLineColor: primaryColor,
    undoneLineColor: disabledColor,
    unselectedStepSize: 25,
    unselectedStepBorderSize: 3,
    doneStepSize: 25,
    selectedStepSize: 25,
    selectedStepBorderSize: 3,
    doneLineThickness: 3,
    undoneLineThickness: 3,
  );
}
