import 'package:nocterm/nocterm.dart';

void main() {
  runApp(const Counter());
}

class Counter extends StatefulComponent {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  @override
  Component build(BuildContext context) {
    return Focusable(
      focused: true,
      onKeyEvent: (event) {
        switch (event.logicalKey) {
          case LogicalKey.arrowUp:
            setState(() {
              _count++;
            });
            return true;
          case LogicalKey.arrowDown:
            setState(() {
              _count--;
            });
            return true;
          case LogicalKey.keyR:
            setState(() {
              _count = 0;
            });
            return true;
          default:
            return false;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: BoxBorder.all(color: Colors.red),
        ),
        margin: EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Counter: $_count'),
            SizedBox(height: 1),
            Text(
              'Press ↑ to increment',
              style: TextStyle(color: Colors.gray),
            ),
            Text(
              'Press ↓ to decrement',
              style: TextStyle(color: Colors.gray),
            ),
            Text(
              'Press R to reset',
              style: TextStyle(color: Colors.gray),
            ),
          ],
        ),
      ),
    );
  }
}
