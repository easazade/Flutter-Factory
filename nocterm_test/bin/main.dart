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
  int _reverseCount = 0;

  @override
  Component build(BuildContext context) {
    return Focusable(
      focused: true,
      onKeyEvent: (event) {
        switch (event.logicalKey) {
          case LogicalKey.arrowUp:
            setState(() {
              _count++;
              _reverseCount--;
            });
            return true;
          case LogicalKey.arrowDown:
            setState(() {
              _count--;
              _reverseCount++;
            });
            return true;
          case LogicalKey.keyR:
            setState(() {
              _count = 0;
              _reverseCount = 0;
            });
            return true;
          default:
            return false;
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: BoxBorder.all(color: Colors.blue),
        ),
        margin: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Counter: $_reverseCount'),
                SizedBox(height: 1),
                Text(
                  'Press ↓ to increment',
                  style: TextStyle(color: Colors.gray),
                ),
                Text(
                  'Press ↑ to decrement',
                  style: TextStyle(color: Colors.gray),
                ),
                Text(
                  'Press R to reset',
                  style: TextStyle(color: Colors.gray),
                ),
              ],
            ),
            Column(
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
          ],
        ),
      ),
    );
  }
}
