import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/pages/form_page.dart';
import 'package:nocterm_test/pages/home_page.dart';
import 'package:nocterm_test/theme.dart';

class MyApp extends StatelessComponent {
  @override
  Component build(BuildContext context) {
    return NoctermApp(
      title: 'App',
      iconName: '😎',
      theme: RosePineTheme.main,
      initialRoute: '/home',
      routes: {
        '/home': (context) => HomePage(),
        '/form': (context) => FormPage(),
      },
    );
  }
}
