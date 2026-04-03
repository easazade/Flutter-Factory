import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/components/app_shell.dart';

class FormPage extends StatefulComponent {
  @override
  State<StatefulComponent> createState() => _State();
}

class _State extends State<FormPage> {
  @override
  Component build(BuildContext context) {
    return AppShell(
      currentRoute: '/form',
      child: Center(child: Text('Form Page')),
    );
  }
}
