import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  bool _isBuying = true;

  bool get isBuying => _isBuying;

  set isBuying(bool value) {
    _isBuying = value;
    notifyListeners();
  }
}
