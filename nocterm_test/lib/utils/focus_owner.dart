import 'package:nocterm/nocterm.dart';
import 'package:nocterm_test/utils/focus_manager.dart';
import 'package:nocterm_test/utils/focus_node.dart';

class FocusOwner extends StatefulComponent {
  FocusOwner({super.key, required this.builder});

  final Component Function(BuildContext context, bool hasFocus) builder;

  @override
  State<StatefulComponent> createState() => FocusOwnerState();
}

class FocusOwnerState extends State<FocusOwner> {
  FocusNode? parentNode;
  late final FocusNode node;

  static FocusManager? _focusManager;

  static FocusManager get focusManager {
    final m = _focusManager;
    assert(m != null, 'FocusOwner root must be mounted before using focusManager.');
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

    final ancestorState = context.findAncestorStateOfType<FocusOwnerState>();
    if (ancestorState != null) {
      parentNode = ancestorState.node;
    }

    node = FocusNode(parent: parentNode, children: []);

    parentNode?.addChild(node);

    if (parentNode == null) {
      assert(
        _focusManager == null,
        'Only one FocusOwner root is allowed; wrap the app (or route) in a single root FocusOwner.',
      );
      _focusManager = FocusManager(rootNode: node);
    }

    final fm = _focusManager!;
    _hasFocus = fm.currentFocus == node;
    fm.addObserver(_onFocusChanged);
  }

  @override
  Component build(BuildContext context) {
    return Builder(
      builder: (context) {
        return component.builder(context, _hasFocus);
      },
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
