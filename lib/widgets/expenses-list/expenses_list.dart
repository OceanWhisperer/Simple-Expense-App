import 'package:expenseapp/models/expense.dart';
import 'package:flutter/material.dart';
import 'package:expenseapp/widgets/expenses-list/expense_item.dart';

class ExpensesList extends StatelessWidget {
  const ExpensesList({
    super.key,
    required this.expenses,
    required this.onremove,
  });

  final List<Expense> expenses;
  final void Function(Expense expense) onremove;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: expenses.length,
      itemBuilder: (ctx, indx) => Dismissible(
        key: ValueKey(expenses[indx]),
        background: Container(
          color: Theme.of(context).colorScheme.error.withOpacity(0.75),
          margin: EdgeInsets.symmetric(
              horizontal: Theme.of(context).cardTheme.margin!.horizontal),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 24,
                ),
              ),
            ],
          ),
        ),
        confirmDismiss: (direction) async {
          // Optional: show a confirmation dialog before dismissing
          return true; // return true to confirm dismiss, false to cancel
        },
        onDismissed: (direction) {
          onremove(expenses[indx]);
        },
        child: ExpenseItem(
          expenses[indx],
        ),
      ),
    );
  }
}
