import 'package:flutter/material.dart';
import 'package:theme/utils.dart';

class ThemeFromSeedPage extends StatefulWidget {
  const ThemeFromSeedPage({super.key});

  @override
  State<ThemeFromSeedPage> createState() => _ThemeFromSeedPageState();
}

class _ThemeFromSeedPageState extends State<ThemeFromSeedPage> {
  @override
  Widget build(BuildContext context) {
    const brightness = Brightness.light;
    final secondaryShades = getColorSchemeShades(Colors.blue, brightness);

    return Material(
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.teal,
            brightness: brightness,
            secondary: secondaryShades.main,
            onSecondary: secondaryShades.onMain,
            secondaryContainer: secondaryShades.mainContainer,
            onSecondaryContainer: secondaryShades.onMainContainer,
          ),
        ),
        child: Builder(
          builder: (context) {
            return Material(
              color: Theme.of(context).colorScheme.background,
              child: Center(
                child: Wrap(
                  alignment: WrapAlignment.center,
                  children: [
                    _ColorBox(Theme.of(context).colorScheme.primary, 'primary'),
                    _ColorBox(Theme.of(context).colorScheme.onPrimary, 'onPrimary'),
                    _ColorBox(Theme.of(context).colorScheme.primaryContainer, 'primaryContainer'),
                    _ColorBox(Theme.of(context).colorScheme.onPrimaryContainer, 'onPrimaryContainer'),
                    _ColorBox(Theme.of(context).colorScheme.secondary, 'secondary'),
                    _ColorBox(Theme.of(context).colorScheme.onSecondary, 'onSecondary'),
                    _ColorBox(Theme.of(context).colorScheme.secondaryContainer, 'secondaryContainer'),
                    _ColorBox(Theme.of(context).colorScheme.onSecondaryContainer, 'onSecondaryContainer'),
                    _ColorBox(Theme.of(context).colorScheme.tertiary, 'tertiary'),
                    _ColorBox(Theme.of(context).colorScheme.onTertiary, 'onTertiary'),
                    _ColorBox(Theme.of(context).colorScheme.tertiaryContainer, 'tertiaryContainer'),
                    _ColorBox(Theme.of(context).colorScheme.onTertiaryContainer, 'onTertiaryContainer'),
                    const Divider(),
                    _ColorBox(Theme.of(context).colorScheme.error, 'error'),
                    _ColorBox(Theme.of(context).colorScheme.onError, 'onError'),
                    _ColorBox(Theme.of(context).colorScheme.errorContainer, 'errorContainer'),
                    _ColorBox(Theme.of(context).colorScheme.onErrorContainer, 'onErrorContainer'),
                    _ColorBox(Theme.of(context).colorScheme.outline, 'outline'),
                    _ColorBox(Theme.of(context).colorScheme.outlineVariant, 'outlineVariant'),
                    _ColorBox(Theme.of(context).colorScheme.background, 'background'),
                    _ColorBox(Theme.of(context).colorScheme.onBackground, 'onBackground'),
                    _ColorBox(Theme.of(context).colorScheme.surface, 'surface'),
                    _ColorBox(Theme.of(context).colorScheme.onSurface, 'onSurface'),
                    _ColorBox(Theme.of(context).colorScheme.surfaceVariant, 'surfaceVariant'),
                    _ColorBox(Theme.of(context).colorScheme.onSurfaceVariant, 'onSurfaceVariant'),
                    _ColorBox(Theme.of(context).colorScheme.inverseSurface, 'inverseSurface'),
                    _ColorBox(Theme.of(context).colorScheme.onInverseSurface, 'onInverseSurface'),
                    _ColorBox(Theme.of(context).colorScheme.inversePrimary, 'inversePrimary'),
                    _ColorBox(Theme.of(context).colorScheme.shadow, 'shadow'),
                    _ColorBox(Theme.of(context).colorScheme.scrim, 'scrim'),
                    _ColorBox(Theme.of(context).colorScheme.surfaceTint, 'surfaceTint'),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ColorBox extends StatelessWidget {
  const _ColorBox(this.color, this.colorRole, {super.key});

  final Color color;

  /// role of the this color in flutter [ColorScheme]
  final String colorRole;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      padding: const EdgeInsets.only(left: 5, right: 5, bottom: 10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 65,
            height: 65,
            color: color,
          ),
          FittedBox(
            child: Text(
              colorRole,
              style: TextStyle(
                fontSize: 10,
                color: Theme.of(context).colorScheme.brightness == Brightness.light ? Colors.black : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
