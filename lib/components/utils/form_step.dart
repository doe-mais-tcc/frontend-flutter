import 'package:flutter/material.dart';

abstract class FormStep extends Widget {
  bool validate();
  dynamic returnData();
}
