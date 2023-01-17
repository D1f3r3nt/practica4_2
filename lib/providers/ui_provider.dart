import 'package:flutter/cupertino.dart';

class UiProvider extends ChangeNotifier {
  int _indexMenu = 0;

  int get indexMenu {
    return _indexMenu;
  }

  set indexMenu(int index) {
    _indexMenu = index;
    notifyListeners();
  }
}
