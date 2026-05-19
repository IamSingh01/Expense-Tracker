import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BudgetProvider extends ChangeNotifier {
  static const _key = 'monthly_budget';
  double _budget = 0.0;

  double get budget => _budget;

  Future<void> loadBudget() async {
    final prefs = await SharedPreferences.getInstance();
    _budget = prefs.getDouble(_key) ?? 0.0;
    notifyListeners();
  }

  Future<void> setBudget(double value) async {
    _budget = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_key, value);
  }
}
