import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  int _indexMenu = 1;

  int get indexMenu {
    return _indexMenu;
  }

  set indexMenu(int index) {
    _indexMenu = index;
    notifyListeners();
  }
}
