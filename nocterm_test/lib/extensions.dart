import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/theme.dart';

extension BuildContextX on BuildContext {
  RosePineTheme get theme => TuiTheme.of(this) as RosePineTheme;
}
