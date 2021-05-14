import 'package:flutter/material.dart';

abstract class FormStep extends Widget {
  final dynamic editObject;
  bool validate();
  dynamic returnData();

  FormStep(this.editObject);
}
