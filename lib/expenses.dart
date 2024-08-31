import 'package:expenseapp/widgets/chart/chart.dart';
import 'package:expenseapp/widgets/new_expense.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/models/expense.dart';
import 'package:expenseapp/widgets/expenses-list/expenses_list.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});
  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredexpenses = [
    Expense(
      title: "Sample Expense",
      amount: 12.99,
      category: Category.work,
      date: DateTime.now(),
    )
  ];

  void _opentheoverlay() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) => NewExpense(_addexpense),
    );
  }

  void _addexpense(Expense expense) {
    setState(() {
      _registeredexpenses.add(expense);
    });
  }

  void removeexpense(Expense expense) {
    final removedexpenseindex = _registeredexpenses.indexOf(expense);
    setState(() {
      _registeredexpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Expense Removed"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
            label: "Undo",
            onPressed: () {
              setState(() {
                _registeredexpenses.insert(removedexpenseindex, expense);
              });
            }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget maincontent;

    if (_registeredexpenses.isEmpty) {
      maincontent = const Center(
        child: Text("No Expense Found. Start Adding some!"),
      );
    } else {
      maincontent =
          ExpensesList(expenses: _registeredexpenses, onremove: removeexpense);
    }

    if (_registeredexpenses.isNotEmpty) {
      ExpensesList(expenses: _registeredexpenses, onremove: removeexpense);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.centerLeft, // Align title to the left
          child: Text("Expense App"),
        ),
        actions: [
          IconButton(
            onPressed: _opentheoverlay,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Column(
        children: [
          Chart(expenses: _registeredexpenses),
          Expanded(
            child: maincontent,
          ),
        ],
      ),
    );
  }
}
