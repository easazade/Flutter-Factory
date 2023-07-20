import 'package:flutter/material.dart';
import 'package:material_color_utilities/scheme/scheme.dart';

/// tricky as fuck, but works for me
/// 
/// returns a ColorSchemeShades which has the 4 shades for material 3 colors
ColorSchemeShades getColorSchemeShades(Color color, Brightness brightness) {
  late Scheme scheme;
  if (brightness == Brightness.light) {
    scheme = Scheme.light(color.value);
  } else {
    scheme = Scheme.dark(color.value);
  }

  return ColorSchemeShades(
    main: Color(scheme.primary),
    onMain: Color(scheme.onPrimary),
    mainContainer: Color(scheme.primaryContainer),
    onMainContainer: Color(scheme.onPrimaryContainer),
  );
}

class ColorSchemeShades {
  ColorSchemeShades({
    required this.main,
    required this.onMain,
    required this.mainContainer,
    required this.onMainContainer,
  });

  final Color main;
  final Color onMain;
  final Color mainContainer;
  final Color onMainContainer;
}
