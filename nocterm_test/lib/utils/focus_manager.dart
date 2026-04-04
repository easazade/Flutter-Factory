import 'package:nocterm_test/components/logger.dart';
import 'package:nocterm_test/utils/focus_node.dart';

typedef FocusObserver = void Function(FocusNode currentFocus);

class FocusManager {
  FocusManager({required FocusNode rootNode}) : _currentFocus = rootNode;

  FocusNode _currentFocus;

  final List<FocusObserver> observers = [];

  FocusNode get currentFocus => _currentFocus;

  void addObserver(FocusObserver observer) {
    observers.add(observer);
  }

  void removeObserver(FocusObserver observer) {
    observers.remove(observer);
  }

  void _notifyObservers() {
    for (final observer in List<FocusObserver>.from(observers)) {
      observer(_currentFocus);
    }
    Logs.instance.add(
      'current focus: ${currentFocus.name ?? currentFocus.id} | children : ${currentFocus.children.map((e) => e.name).join(',')} | parent: ${currentFocus.parent?.name ?? currentFocus.parent?.id}',
    );
  }

  void next() {
    if (!_currentFocus.hasSiblings) {
      return;
    }
    final siblings = _currentFocus.allParentsChildren;
    final currentIndex = _currentFocus.index;
    final nextIndex = (currentIndex + 1) % siblings.length;
    if (currentIndex != nextIndex) {
      _currentFocus = siblings[nextIndex];
      _notifyObservers();
    }
  }

  void previous() {
    if (!_currentFocus.hasSiblings) {
      return;
    }
    final siblings = _currentFocus.allParentsChildren;
    final currentIndex = _currentFocus.index;
    final previousIndex =
        (currentIndex - 1 + siblings.length) % siblings.length;
    if (currentIndex != previousIndex) {
      _currentFocus = siblings[previousIndex];
      _notifyObservers();
    }
  }

  void inside() {
    if (!_currentFocus.hasChildren) {
      return;
    }
    _currentFocus = _currentFocus.children.first;
    _notifyObservers();
  }

  void outside() {
    final parent = _currentFocus.parent;
    if (parent == null) {
      return;
    }
    _currentFocus = parent;
    _notifyObservers();
  }

  void addNode({required FocusNode node, required FocusNode parentNode}) {
    parentNode.insertChild(node);
    _notifyObservers();
  }

  void dispose() {
    observers.clear();
  }
}
