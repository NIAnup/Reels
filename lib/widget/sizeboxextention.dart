import 'package:flutter/material.dart';

extension Sizebox on double {
  SizedBox get h => SizedBox(
        height: toDouble(),
      );
  SizedBox get w => SizedBox(
        width: toDouble(),
      );
}
