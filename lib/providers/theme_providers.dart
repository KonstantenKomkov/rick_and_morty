import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData current(Brightness? brightness) =>
      brightness == Brightness.dark ? ThemeData.dark() : ThemeData.light();
}
