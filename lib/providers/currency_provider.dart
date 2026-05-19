import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Currency {
  usd('\$', 'USD'),
  aed('AED ', 'AED'),
  inr('₹', 'INR'),
  eur('€', 'EUR');

  final String symbol;
  final String code;
  const Currency(this.symbol, this.code);
}

class CurrencyProvider extends ChangeNotifier {
  static const _key = 'selected_currency';
  Currency _selectedCurrency = Currency.usd;

  Currency get selectedCurrency => _selectedCurrency;

  Future<void> loadCurrency() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString(_key);
    if (code != null) {
      _selectedCurrency = Currency.values.firstWhere(
        (c) => c.code == code,
        orElse: () => Currency.usd,
      );
      notifyListeners();
    }
  }

  Future<void> setCurrency(Currency currency) async {
    _selectedCurrency = currency;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, currency.code);
  }
}
