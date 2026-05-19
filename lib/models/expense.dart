import 'package:flutter/material.dart';

enum ExpenseCategory { food, transport, shopping, bills, entertainment, health, other }

extension CategoryX on ExpenseCategory {
  String get label => switch (this) {
    ExpenseCategory.food => 'Food',
    ExpenseCategory.transport => 'Transport',
    ExpenseCategory.shopping => 'Shopping',
    ExpenseCategory.bills => 'Bills',
    ExpenseCategory.entertainment => 'Entertainment',
    ExpenseCategory.health => 'Health',
    ExpenseCategory.other => 'Other',
  };

  IconData get icon => switch (this) {
    ExpenseCategory.food => Icons.restaurant_rounded,
    ExpenseCategory.transport => Icons.directions_car_rounded,
    ExpenseCategory.shopping => Icons.shopping_bag_rounded,
    ExpenseCategory.bills => Icons.receipt_long_rounded,
    ExpenseCategory.entertainment => Icons.movie_rounded,
    ExpenseCategory.health => Icons.favorite_rounded,
    ExpenseCategory.other => Icons.category_rounded,
  };

  Color get color => switch (this) {
    ExpenseCategory.food => const Color(0xFFFF7675),
    ExpenseCategory.transport => const Color(0xFF74B9FF),
    ExpenseCategory.shopping => const Color(0xFFFD79A8),
    ExpenseCategory.bills => const Color(0xFFFDCB6E),
    ExpenseCategory.entertainment => const Color(0xFFA29BFE),
    ExpenseCategory.health => const Color(0xFF55EFC4),
    ExpenseCategory.other => const Color(0xFFB2BEC3),
  };
}

class Expense {
  final int? id;
  final String title;
  final double amount;
  final ExpenseCategory category;
  final DateTime date;
  final String? note;

  Expense({
    this.id,
    required this.title,
    required this.amount,
    required this.category,
    required this.date,
    this.note,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'amount': amount,
    'category': category.name,
    'date': date.millisecondsSinceEpoch,
    'note': note,
  };

  factory Expense.fromMap(Map<String, dynamic> map) => Expense(
    id: map['id'] as int?,
    title: map['title'] as String,
    amount: (map['amount'] as num).toDouble(),
    category: ExpenseCategory.values.firstWhere(
          (e) => e.name == map['category'],
      orElse: () => ExpenseCategory.other,
    ),
    date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
    note: map['note'] as String?,
  );

  Expense copyWith({
    int? id,
    String? title,
    double? amount,
    ExpenseCategory? category,
    DateTime? date,
    String? note,
  }) =>
      Expense(
        id: id ?? this.id,
        title: title ?? this.title,
        amount: amount ?? this.amount,
        category: category ?? this.category,
        date: date ?? this.date,
        note: note ?? this.note,
      );
}