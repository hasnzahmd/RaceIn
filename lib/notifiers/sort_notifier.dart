import 'package:flutter/material.dart';

enum SortOrder { nameAsc, nameDesc, points }

class SortNotifier extends ChangeNotifier {
  SortOrder _sortOrder = SortOrder.nameAsc;

  SortOrder get sortOrder => _sortOrder;

  void setSortOrder(SortOrder order) {
    _sortOrder = order;
    notifyListeners();
  }
}
