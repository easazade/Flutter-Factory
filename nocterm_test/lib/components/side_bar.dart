import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/extensions.dart';
import 'package:nocterm_test/utils/focus_owner.dart';

class SideBar extends StatelessComponent {
  const SideBar({super.key, required this.currentRoute});

  final String currentRoute;

  @override
  Component build(BuildContext context) {
    final theme = context.theme;
    return Container(
      width: 18,
      padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      decoration: BoxDecoration(
        border: BoxBorder(
          right: BorderSide(color: theme.rosePineHighlightHigh),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _navItem(context, route: '/home', label: 'Home'),
          _navItem(context, route: '/form', label: 'Form'),
        ],
      ),
    );
  }

  Component _navItem(
    BuildContext context, {
    required String route,
    required String label,
  }) {
    final theme = context.theme;
    final active = currentRoute == route;
    return FocusOwner(
      onKeyEvent: (_) => false,
      onEnterPressed: () {
        Navigator.of(context).pushReplacementNamed(route);
      },
      builder: (context, hasFocus) {
        final color = active
            ? theme.rosePineFoam
            : (hasFocus ? theme.rosePineText : theme.rosePineMuted);
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1),
          child: Text(
            label,
            style: TextStyle(
              color: color,
              fontWeight: active ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      },
    );
  }
}
