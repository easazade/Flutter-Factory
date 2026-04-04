import 'dart:math';

class FocusNode {
  final FocusNode? parent;
  final List<FocusNode> _children;
  final String id;

  /// Optional human-readable label for logging and debugging.
  final String? name;

  FocusNode({
    required this.parent,
    required List<FocusNode> children,
    String? id,
    this.name,
  }) : id = id ?? newNodeId(),
       _children = children;

  Iterable<FocusNode> get children => _children;

  void insertChild(FocusNode node) {
    _children.add(node);
  }

  /// Resolved label for messages when [name] is null.
  String get displayLabel => name ?? '(unnamed:$id)';

  bool get hasChildren => _children.isNotEmpty;

  bool get hasSiblings => (parent?._children.length ?? 0) > 1;

  List<FocusNode> get allParentsChildren => parent?._children ?? [];

  int get index {
    if (parent == null) {
      return -1;
    } else {
      return parent!._children.indexOf(this);
    }
  }

  void removeChild(FocusNode node) {
    _children.removeWhere((e) => e == node);
  }

  @override
  bool operator ==(Object other) {
    if (other is! FocusNode) {
      return false;
    }
    return id == other.id;
  }

  @override
  int get hashCode => Object.hashAll([id]);
}

String newNodeId() {
  const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
  final r = Random();
  return List.generate(10, (_) => chars[r.nextInt(chars.length)]).join();
}
