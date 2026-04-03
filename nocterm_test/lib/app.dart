import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/components/theme_switcher.dart';
import 'package:nocterm_test/pages/home_page.dart';
import 'package:nocterm_test/theme.dart';

class MyApp extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return NoctermApp(
      title: 'App',
      iconName: '😎',
      theme: RosePineTheme.main,
      child: ThemeSwitcher(child: HomePage()),
    );
  }
}
