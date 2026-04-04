import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/extensions.dart';
import 'package:nocterm_test/utils/focus_owner.dart';

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
    return FocusOwner(
      name: 'counter',
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
      builder: (context, hasFocus) {
        return Container(
          decoration: BoxDecoration(
            color: context.theme.background,
            title: BorderTitle(
              text: 'Counter',
              alignment: TitleAlignment.center,
            ),
            border: BoxBorder.all(
              color: hasFocus
                  ? context.theme.rosePineHighlightHigh
                  : context.theme.rosePineHighlightLow,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Counter: $_reverseCount',
                    style: TextStyle(color: context.theme.rosePineLove),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'Press ↓ to increment',
                    style: TextStyle(color: context.theme.rosePineText),
                  ),
                  Text(
                    'Press ↑ to decrement',
                    style: TextStyle(color: context.theme.rosePineText),
                  ),
                  Text(
                    'Press R to reset',
                    style: TextStyle(color: context.theme.rosePineText),
                  ),
                ],
              ),
              VerticalDivider(style: DividerStyle.dashed),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Counter: $_count',
                    style: TextStyle(color: context.theme.rosePineGold),
                  ),
                  SizedBox(height: 1),
                  Text(
                    'Press ↑ to increment',
                    style: TextStyle(color: context.theme.rosePineText),
                  ),
                  Text(
                    'Press ↓ to decrement',
                    style: TextStyle(color: context.theme.rosePineText),
                  ),
                  Text(
                    'Press R to reset',
                    style: TextStyle(color: context.theme.rosePineText),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
