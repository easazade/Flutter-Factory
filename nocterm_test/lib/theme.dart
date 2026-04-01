import 'package:nocterm/nocterm.dart';

/// Rosé Pine TUI theme with the official palette from
/// [Rosé Pine](https://rosepinetheme.com/palette/).
///
/// Use [RosePineTheme.main], [RosePineTheme.moon], or [RosePineTheme.dawn].
/// Each variant exposes the full ingredient list as [rosePine*] fields with
/// roles described on the palette site.
class RosePineTheme extends TuiThemeData {
  /// Primary background — main and accessory panels: application frames,
  /// sidebars, tabs, and extensions to the focal context.
  final Color rosePineBase;

  /// Secondary background atop base — panels not directly related to the focal
  /// context: cards, inputs, and status lines.
  final Color rosePineSurface;

  /// Tertiary background atop surface — more temporary panels: popovers,
  /// notifications, and dialogs.
  final Color rosePineOverlay;

  /// Low contrast foreground — ignored content: disabled elements and
  /// unfocused text; comments in syntax themes.
  final Color rosePineMuted;

  /// Medium contrast foreground — secondary content: comments, punctuation,
  /// and tab names; operators in syntax themes.
  final Color rosePineSubtle;

  /// High contrast foreground — primary content: normal text, variables, and
  /// active content.
  final Color rosePineText;

  /// Diagnostic errors; deleted Git files; terminal red; builtins.
  final Color rosePineLove;

  /// Diagnostic warnings; terminal yellow; strings.
  final Color rosePineGold;

  /// Matching search background (paired with base foreground); modified Git
  /// files; terminal cyan; booleans; functions.
  final Color rosePineRose;

  /// Renamed Git files; terminal green; conditionals; keywords.
  final Color rosePinePine;

  /// Diagnostic information; Git additions; terminal blue; keys; tags; types.
  final Color rosePineFoam;

  /// Diagnostic hints; inline links; merged and staged Git modifications;
  /// terminal magenta; methods; parameters.
  final Color rosePineIris;

  /// Low contrast highlight — cursor line background.
  final Color rosePineHighlightLow;

  /// Medium contrast highlight — selection background paired with text
  /// foreground.
  final Color rosePineHighlightMed;

  /// High contrast highlight — borders and visual dividers; cursor background
  /// paired with text foreground.
  final Color rosePineHighlightHigh;

  const RosePineTheme._({
    required super.brightness,
    required super.background,
    required super.onBackground,
    required super.surface,
    required super.onSurface,
    required super.primary,
    required super.onPrimary,
    required super.secondary,
    required super.onSecondary,
    required super.error,
    required super.onError,
    required super.success,
    required super.onSuccess,
    required super.warning,
    required super.onWarning,
    required super.outline,
    required super.outlineVariant,
    required super.selectionColor,
    required this.rosePineBase,
    required this.rosePineSurface,
    required this.rosePineOverlay,
    required this.rosePineMuted,
    required this.rosePineSubtle,
    required this.rosePineText,
    required this.rosePineLove,
    required this.rosePineGold,
    required this.rosePineRose,
    required this.rosePinePine,
    required this.rosePineFoam,
    required this.rosePineIris,
    required this.rosePineHighlightLow,
    required this.rosePineHighlightMed,
    required this.rosePineHighlightHigh,
  });

  /// Rosé Pine **main** — default dark variant.
  ///
  /// Hex values from
  /// [ingredients](https://rosepinetheme.com/palette/ingredients/).
  static const RosePineTheme main = RosePineTheme._(
    brightness: Brightness.dark,
    background: Color(0xFF191724),
    onBackground: Color(0xFFE0DEF4),
    surface: Color(0xFF1F1D2E),
    onSurface: Color(0xFFE0DEF4),
    primary: Color(0xFFC4A7E7),
    onPrimary: Color(0xFF191724),
    secondary: Color(0xFFEBBCBA),
    onSecondary: Color(0xFF191724),
    error: Color(0xFFEB6F92),
    onError: Color(0xFF191724),
    success: Color(0xFF31748F),
    onSuccess: Color(0xFFE0DEF4),
    warning: Color(0xFFF6C177),
    onWarning: Color(0xFF191724),
    outline: Color(0xFF524F67),
    outlineVariant: Color(0xFF908CAA),
    selectionColor: Color(0xFF403D52),
    rosePineBase: Color(0xFF191724),
    rosePineSurface: Color(0xFF1F1D2E),
    rosePineOverlay: Color(0xFF26233A),
    rosePineMuted: Color(0xFF6E6A86),
    rosePineSubtle: Color(0xFF908CAA),
    rosePineText: Color(0xFFE0DEF4),
    rosePineLove: Color(0xFFEB6F92),
    rosePineGold: Color(0xFFF6C177),
    rosePineRose: Color(0xFFEBBCBA),
    rosePinePine: Color(0xFF31748F),
    rosePineFoam: Color(0xFF9CCFD8),
    rosePineIris: Color(0xFFC4A7E7),
    rosePineHighlightLow: Color(0xFF21202E),
    rosePineHighlightMed: Color(0xFF403D52),
    rosePineHighlightHigh: Color(0xFF524F67),
  );

  /// Rosé Pine **moon** — alternate dark variant (cooler base/surface).
  static const RosePineTheme moon = RosePineTheme._(
    brightness: Brightness.dark,
    background: Color(0xFF232136),
    onBackground: Color(0xFFE0DEF4),
    surface: Color(0xFF2A273F),
    onSurface: Color(0xFFE0DEF4),
    primary: Color(0xFFC4A7E7),
    onPrimary: Color(0xFF232136),
    secondary: Color(0xFFEA9A97),
    onSecondary: Color(0xFF232136),
    error: Color(0xFFEB6F92),
    onError: Color(0xFF232136),
    success: Color(0xFF3E8FB0),
    onSuccess: Color(0xFFE0DEF4),
    warning: Color(0xFFF6C177),
    onWarning: Color(0xFF232136),
    outline: Color(0xFF56526E),
    outlineVariant: Color(0xFF908CAA),
    selectionColor: Color(0xFF44415A),
    rosePineBase: Color(0xFF232136),
    rosePineSurface: Color(0xFF2A273F),
    rosePineOverlay: Color(0xFF393552),
    rosePineMuted: Color(0xFF6E6A86),
    rosePineSubtle: Color(0xFF908CAA),
    rosePineText: Color(0xFFE0DEF4),
    rosePineLove: Color(0xFFEB6F92),
    rosePineGold: Color(0xFFF6C177),
    rosePineRose: Color(0xFFEA9A97),
    rosePinePine: Color(0xFF3E8FB0),
    rosePineFoam: Color(0xFF9CCFD8),
    rosePineIris: Color(0xFFC4A7E7),
    rosePineHighlightLow: Color(0xFF2A283E),
    rosePineHighlightMed: Color(0xFF44415A),
    rosePineHighlightHigh: Color(0xFF56526E),
  );

  /// Rosé Pine **dawn** — light variant.
  static const RosePineTheme dawn = RosePineTheme._(
    brightness: Brightness.light,
    background: Color(0xFFFAF4ED),
    onBackground: Color(0xFF575279),
    surface: Color(0xFFFFFAF3),
    onSurface: Color(0xFF575279),
    primary: Color(0xFF907AA9),
    onPrimary: Color(0xFFFFFAF3),
    secondary: Color(0xFFD7827E),
    onSecondary: Color(0xFFFAF4ED),
    error: Color(0xFFB4637A),
    onError: Color(0xFFFFFAF3),
    success: Color(0xFF286983),
    onSuccess: Color(0xFFFFFAF3),
    warning: Color(0xFFEA9D34),
    onWarning: Color(0xFFFAF4ED),
    outline: Color(0xFFCECACD),
    outlineVariant: Color(0xFF797593),
    selectionColor: Color(0xFFDFDAD9),
    rosePineBase: Color(0xFFFAF4ED),
    rosePineSurface: Color(0xFFFFFAF3),
    rosePineOverlay: Color(0xFFF2E9E1),
    rosePineMuted: Color(0xFF9893A5),
    rosePineSubtle: Color(0xFF797593),
    rosePineText: Color(0xFF575279),
    rosePineLove: Color(0xFFB4637A),
    rosePineGold: Color(0xFFEA9D34),
    rosePineRose: Color(0xFFD7827E),
    rosePinePine: Color(0xFF286983),
    rosePineFoam: Color(0xFF56949F),
    rosePineIris: Color(0xFF907AA9),
    rosePineHighlightLow: Color(0xFFF4EDE8),
    rosePineHighlightMed: Color(0xFFDFDAD9),
    rosePineHighlightHigh: Color(0xFFCECACD),
  );
}


