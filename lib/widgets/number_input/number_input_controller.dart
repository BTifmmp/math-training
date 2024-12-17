import 'package:flutter/material.dart';

class NumberInputController with ChangeNotifier {
  String value = '';
  bool clearScheduled = false;

  void delayedClear(Duration delay) async {
    clearScheduled = true;
    Future.delayed(delay, () {
      if (clearScheduled) {
        value = '';
        clearScheduled = false;
        notifyListeners();
      }
    });
  }

  void clear() {
    value = '';
    notifyListeners();
  }

  void add(String value) {
    if (clearScheduled) {
      clearScheduled = false;
      this.value = _nextValue('', value);
    } else {
      this.value = _nextValue(this.value, value);
    }

    notifyListeners();
  }

  String _nextValue(String currentValue, String addedValue) {
    if (currentValue == '0' && addedValue != '.') {
      return addedValue;
    }
    if (addedValue == '.') {
      if (currentValue == '') {
        return '0.';
      } else if (currentValue.endsWith('.')) {
        return currentValue;
      }
    }

    return currentValue + addedValue;
  }
}
