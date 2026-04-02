import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/theme.dart';

class ThemeSwitcher extends StatefulComponent {
  const ThemeSwitcher({super.key, required this.child});
  final Component child;

  @override
  State<ThemeSwitcher> createState() => _ThemeSwitcherState();
}

class _ThemeSwitcherState extends State<ThemeSwitcher> {
  TuiThemeData _theme = RosePineTheme.main;

  void _toggleTheme() {
    setState(() {
      _theme = _theme.brightness == Brightness.dark
          ? RosePineTheme.dawn
          : RosePineTheme.main;
    });
  }

  @override
  Component build(BuildContext context) {
    return TuiTheme(
      data: _theme,
      child: Focusable(
        focused: true,
        onKeyEvent: (event) {
          if (event.logicalKey == LogicalKey.keyT) {
            _toggleTheme();
            return true;
          }
          return false;
        },
        child: component.child,
      ),
    );
  }
}
