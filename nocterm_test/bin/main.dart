import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/theme.dart';

void main() {
  runApp(
    TuiTheme(
      data: RosePineTheme.main,
      child: Counter(),
    ),
  );
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
    final theme = TuiTheme.of(context) as RosePineTheme;

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
          color: theme.background,
        ),
        margin: EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter: $_reverseCount',
                  style: TextStyle(color: theme.rosePineLove),
                ),
                SizedBox(height: 1),
                Text(
                  'Press ↓ to increment',
                  style: TextStyle(color: theme.rosePineText),
                ),
                Text(
                  'Press ↑ to decrement',
                  style: TextStyle(color: theme.rosePineText),
                ),
                Text(
                  'Press R to reset',
                  style: TextStyle(color: theme.rosePineText),
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Counter: $_count',
                  style: TextStyle(color: theme.rosePineGold),
                ),
                SizedBox(height: 1),
                Text(
                  'Press ↑ to increment',
                  style: TextStyle(color: theme.rosePineText),
                ),
                Text(
                  'Press ↓ to decrement',
                  style: TextStyle(color: theme.rosePineText),
                ),
                Text(
                  'Press R to reset',
                  style: TextStyle(color: theme.rosePineText),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
