import 'package:nocterm/nocterm.dart';
import 'package:nocterm/nocterm_test.dart';
import 'package:nocterm_test/app.dart';
import 'package:test/test.dart';

void main() {
  test('counter test', () async {
    await testNocterm('simple component test for demonstration', (
      tester,
    ) async {
      await tester.pumpComponent(MyApp());
      expect(tester.terminalState, containsText('Counter: 0'));

      await tester.sendArrowUp();
      expect(tester.terminalState, containsText('Counter: 1'));
      expect(tester.terminalState, containsText('Counter: -1'));
    });
  });
}
