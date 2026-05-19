import 'package:flutter/material.dart';
import '../database/database_helper.dart';
import '../models/expense.dart';

class ExpenseProvider extends ChangeNotifier {
  final _db = DatabaseHelper.instance;
  List<Expense> _expenses = [];
  bool _loading = false;

  List<Expense> get expenses => _expenses;
  bool get loading => _loading;

  double get totalSpent => _expenses.fold(0, (sum, e) => sum + e.amount);

  double get monthlySpent {
    final now = DateTime.now();
    return _expenses
        .where((e) => e.date.year == now.year && e.date.month == now.month)
        .fold(0.0, (sum, e) => sum + e.amount);
  }

  Map<ExpenseCategory, double> get categoryTotals {
    final map = <ExpenseCategory, double>{};
    for (final e in _expenses) {
      map[e.category] = (map[e.category] ?? 0) + e.amount;
    }
    return map;
  }

  Future<void> loadExpenses() async {
    _loading = true;
    notifyListeners();
    _expenses = await _db.getAllExpenses();
    _loading = false;
    notifyListeners();
  }

  Future<void> addExpense(Expense expense) async {
    final id = await _db.insertExpense(expense);
    _expenses.insert(0, expense.copyWith(id: id));
    notifyListeners();
  }

  Future<void> updateExpense(Expense expense) async {
    await _db.updateExpense(expense);
    final i = _expenses.indexWhere((e) => e.id == expense.id);
    if (i != -1) _expenses[i] = expense;
    notifyListeners();
  }

  Future<void> deleteExpense(int id) async {
    await _db.deleteExpense(id);
    _expenses.removeWhere((e) => e.id == id);
    notifyListeners();
  }
}