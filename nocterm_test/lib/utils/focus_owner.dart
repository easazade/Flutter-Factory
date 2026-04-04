import 'dart:developer';

import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/utils/focus_manager.dart';
import 'package:nocterm_test/utils/focus_node.dart';

class FocusOwner extends StatefulComponent {
  FocusOwner({
    super.key,
    required this.builder,
    required this.onKeyEvent,
    this.name,
    this.onEnterPressed,
    this.onTabPressed,
    this.onShiftTabPressed,
    this.onEscapePressed,
  });

  /// Optional label for focus tree logging; forwarded to [FocusNode.name].
  final String? name;

  final Component Function(BuildContext context, bool hasFocus) builder;
  final bool Function(KeyboardEvent event) onKeyEvent;

  /// When non-null, replaces the default Enter behavior ([FocusManager.inside]).
  final void Function()? onEnterPressed;

  /// When non-null, replaces the default Tab behavior ([FocusManager.next]).
  final void Function()? onTabPressed;

  /// When non-null, replaces the default Shift+Tab behavior
  /// ([FocusManager.previous]).
  final void Function()? onShiftTabPressed;

  /// When non-null, replaces the default Escape behavior ([FocusManager.outside]).
  final void Function()? onEscapePressed;

  @override
  State<StatefulComponent> createState() => FocusOwnerState();
}

class FocusOwnerState extends State<FocusOwner> {
  FocusNode? parentNode;
  late final FocusNode node;

  static FocusManager? _focusManager;

  static FocusManager get focusManager {
    final m = _focusManager;
    assert(
      m != null,
      'FocusOwner root must be mounted before using focusManager.',
    );
    return m!;
  }

  bool _hasFocus = false;

  void _onFocusChanged(FocusNode focus) {
    final focused = focus == node;
    if (_hasFocus != focused) {
      setState(() {
        _hasFocus = focused;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    log('${component.name} initState');
    final ancestorState = context.findAncestorStateOfType<FocusOwnerState>();
    if (ancestorState != null) {
      parentNode = ancestorState.node;
    }

    node = FocusNode(parent: parentNode, children: [], name: component.name);

    if (parentNode == null) {
      assert(
        _focusManager == null,
        'Only one FocusOwner root is allowed; wrap the app (or route) in a single root FocusOwner.',
      );
      _focusManager = FocusManager(rootNode: node);
    }

    _hasFocus = focusManager.currentFocus == node;
    focusManager.addObserver(_onFocusChanged);

    if (parentNode != null) {
      focusManager.addNode(node: node, parentNode: parentNode!);
    }
  }

  @override
  Component build(BuildContext context) {
    return Focusable(
      focused: _hasFocus,
      onKeyEvent: (event) {
        final key = event.logicalKey;
        if (key == LogicalKey.tab) {
          if (event.isShiftPressed) {
            if (component.onShiftTabPressed != null) {
              component.onShiftTabPressed!();
              return true;
            }
            focusManager.previous();
          } else {
            if (component.onTabPressed != null) {
              component.onTabPressed!();
              return true;
            }
            focusManager.next();
          }
          return true;
        }
        if (key == LogicalKey.enter) {
          if (component.onEnterPressed != null) {
            component.onEnterPressed!();
            return true;
          }
          focusManager.inside();
          return true;
        }
        if (key == LogicalKey.escape) {
          if (component.onEscapePressed != null) {
            component.onEscapePressed!();
            return true;
          }
          focusManager.outside();
          return true;
        }
        return component.onKeyEvent(event);
      },
      child: Builder(
        builder: (context) {
          return component.builder(context, _hasFocus);
        },
      ),
    );
  }

  @override
  void dispose() {
    _focusManager?.removeObserver(_onFocusChanged);
    parentNode?.removeChild(node);
    if (parentNode == null) {
      _focusManager?.dispose();
      _focusManager = null;
    }
    super.dispose();
  }
}
