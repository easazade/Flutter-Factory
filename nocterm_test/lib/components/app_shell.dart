import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/components/side_bar.dart';
import 'package:nocterm_test/utils/focus_owner.dart';

/// Shared layout: root [FocusOwner], left [SideBar], and main content in a
/// focus scope for tab order.
class AppShell extends StatelessComponent {
  const AppShell({super.key, required this.currentRoute, required this.child});

  final String currentRoute;
  final Component child;

  @override
  Component build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Flexible(child: AppLogs()),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SideBar(currentRoute: currentRoute),
              Expanded(
                child: child,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
