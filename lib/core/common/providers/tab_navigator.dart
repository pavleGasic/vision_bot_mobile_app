import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:uuid/uuid.dart';

class TabNavigator extends ChangeNotifier {
  TabNavigator(this._initialPage) {
    _navigationStack.add(_initialPage);
  }

  final TabItem _initialPage;
  final List<TabItem> _navigationStack = [];

  TabItem get currentPage => _navigationStack.last;

  void push(Widget page) {
    _navigationStack.add(TabItem(child: page));
    notifyListeners();
  }

  void pop() {
    if (_navigationStack.isNotEmpty) _navigationStack.removeLast();
    notifyListeners();
  }

  void popToRoot() {
    _navigationStack
      ..clear()
      ..add(_initialPage);
    notifyListeners();
  }
}

class TabNavigatorProvider extends InheritedNotifier<TabNavigator> {
  const TabNavigatorProvider({
    required this.navigator,
    required super.child,
    super.key,
  }): super(notifier: navigator);

  final TabNavigator navigator;

  static TabNavigator? of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TabNavigatorProvider>()
        ?.navigator;
  }
}

class TabItem extends Equatable {
  TabItem({required this.child}) : id = const Uuid().v1();

  final Widget child;
  final String id;

  @override
  List<Object?> get props => [id];
}
