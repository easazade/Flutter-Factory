import 'package:nocterm/nocterm.dart';

class AppLogs extends StatefulComponent {
  @override
  State<StatefulComponent> createState() => _State();
}

class _State extends State<AppLogs> {
  @override
  Component build(BuildContext context) {
    return ListenableBuilder(
      listenable: Logs.instance,
      builder: (context, child) {
        final items = Logs.instance.items;
        return ListView.builder(
          itemBuilder: (context, index) {
            return Text(items[index]);
          },
          itemCount: items.length,
        );
      },
    );
  }
}

class Logs extends ChangeNotifier {
  final items = <String>[];

  static final instance = Logs();

  void add(dynamic value) {
    items.add(value.toString());
    notifyListeners();
  }
}
