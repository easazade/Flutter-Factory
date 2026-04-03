import 'package:nocterm/nocterm.dart';

class FormPage extends StatefulComponent {
  @override
  State<StatefulComponent> createState() => _State();
}

class _State extends State<FormPage> {
  @override
  Component build(BuildContext context) {
    return Center(child: Text('Form Page'));
  }
}
