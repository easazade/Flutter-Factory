import 'dart:math';

class FocusNode {
  final FocusNode? parent;
  final List<FocusNode> children;
  final String id;

  FocusNode({required this.parent, required this.children, String? id})
    : id = id ?? newNodeId();

  bool get hasChildren => children.isNotEmpty;

  bool get hasSiblings => (parent?.children.length ?? 0) > 1;

  List<FocusNode> get allParentsChildren => parent?.children ?? [];

  void addChild(FocusNode node) {
    children.add(node);
  }

  int get index {
    if (parent == null) {
      return -1;
    } else {
      return parent!.children.indexOf(this);
    }
  }

  void removeChild(FocusNode node) {
    children.removeWhere((e) => e == node);
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
