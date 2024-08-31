import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:expenseapp/models/expense.dart';

class NewExpense extends StatefulWidget {
  const NewExpense(this.onaddexpense, {super.key});
  final void Function(Expense expense) onaddexpense;
  @override
  State<NewExpense> createState() => _NewExpenseState();
}

class _NewExpenseState extends State<NewExpense> {
  final _titlecontroller = TextEditingController();
  final _amountcontroller = TextEditingController();
  DateTime? _selecteddate;
  Category _selectedcategory = Category.leisure;

  @override
  void dispose() {
    _titlecontroller.dispose();
    _amountcontroller.dispose();
    super.dispose();
  }

  void _presentdatepicker() async {
    final now = DateTime.now();
    final firstdate = DateTime(now.year - 1, now.month, now.day);
    final finaldate = DateTime.now();

    final pickeddate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstdate,
        lastDate: finaldate);

    setState(() {
      _selecteddate = pickeddate;
    });
  }

  void _submitexpensedata() {
    final enteredAmount = double.tryParse(_amountcontroller.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;
    final titleIsEmpty = _titlecontroller.text.trim().isEmpty;
    final dateIsNull = _selecteddate == null;

    String errorMessage =
        "Please make sure the following fields are correctly filled:\n";

    if (titleIsEmpty) {
      errorMessage += "- Title\n";
    }
    if (amountIsInvalid) {
      errorMessage += "- Amount\n";
    }
    if (dateIsNull) {
      errorMessage += "- Date\n";
    }

    if (titleIsEmpty || amountIsInvalid || dateIsNull) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text("Invalid Input"),
          content: Text(errorMessage.trim().isEmpty
              ? "Please enter all fields."
              : errorMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Close"),
            ),
          ],
        ),
      );

      return;
    }

    widget.onaddexpense(
      Expense(
        title: _titlecontroller.text,
        amount: double.parse(_amountcontroller.text),
        category: _selectedcategory,
        date: _selecteddate!,
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 750),
      () {
        if (mounted) {
          Navigator.pop(context);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(children: [
        TextField(
          controller: _titlecontroller,
          maxLength: 20,
          decoration: const InputDecoration(
            label: Text("Title"),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _amountcontroller,
                maxLength: 50,
                keyboardType: const TextInputType.numberWithOptions(
                    decimal: true), // Allows decimal numbers
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.allow(RegExp(
                      r'^\d*\.?\d*$')), // Allows digits and a single decimal point
                ],
                decoration: const InputDecoration(
                  prefixText: '\$',
                  label: Text("Amount"),
                ),
              ),
            ),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    _selecteddate == null
                        ? "No date selected"
                        : formatter.format(_selecteddate!),
                  ),
                  IconButton(
                    onPressed: _presentdatepicker,
                    icon: const Icon(Icons.calendar_month),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            DropdownButton(
              value: _selectedcategory,
              items: Category.values
                  .map(
                    (cat) => DropdownMenuItem(
                      value: cat,
                      child: Text(cat.name.toUpperCase()),
                    ),
                  )
                  .toList(),
              onChanged: (value) {
                setState(() {
                  if (value == null) {
                    return;
                  }
                  _selectedcategory = value;
                });
              },
            ),
            const Spacer(),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    _submitexpensedata();
                  },
                  child: const Text("Save Expense"),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"))
              ],
            )
          ],
        )
      ]),
    );
  }
}
