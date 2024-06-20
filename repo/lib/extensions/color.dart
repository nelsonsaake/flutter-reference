import 'package:flutter/material.dart';

extension ToMaterialColor on Color {
  MaterialColor get toMaterial {
    return MaterialColor(
      value,
      {
        50: this,
        100: this,
        200: this,
        300: this,
        400: this,
        500: this,
        600: this,
        700: this,
        800: this,
        900: this,
      },
    );
  }
}

extension ToMaterialProperty on Color {
  MaterialStateProperty<Color?> get toMaterialProperty {
    return MaterialStateProperty.all<Color?>(Color(value));
  }
}
