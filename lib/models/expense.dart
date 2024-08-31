import 'package:uuid/uuid.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const uuid = Uuid();

enum Category { food, travel, leisure, work }

final formatter = DateFormat.yMd();

const categoryicons = {
  Category.food: Icons.lunch_dining,
  Category.leisure: Icons.movie,
  Category.travel: Icons.flight_takeoff,
  Category.work: Icons.work
};

class Expense {
  Expense(
      {required this.title,
      required this.amount,
      required this.date,
      required this.category})
      : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;

  String get formatteddate {
    return formatter.format(date);
  }
}

class ExpenseBucket {
  const ExpenseBucket({required this.category, required this.expenses});
  ExpenseBucket.forCategory(List<Expense> allexpenses, this.category)
      : expenses =
            allexpenses.where((ele) => ele.category == category).toList();
  final Category category;
  final List<Expense> expenses;

  double get totalexpenses {
    // returns total sum of all expenses
    double sum = 0;
    for (final expense in expenses) {
      sum = sum + expense.amount;
    }
    return sum;
  }
}
