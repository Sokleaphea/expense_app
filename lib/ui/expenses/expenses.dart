import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpensesView extends StatefulWidget {
  final List<Expense> expenses;
  const ExpensesView({super.key, required this.expenses});

  @override
  State<ExpensesView> createState() {
    return _ExpensesViewState();
  }
}

class _ExpensesViewState extends State<ExpensesView> {
  void removeExpense(int index) {
    final removedExpense = widget.expenses[index];
    setState(() {
      widget.expenses.removeAt(index);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(removedExpense.title),
        action: SnackBarAction(
          label: "UNDO",
          onPressed: () {
            setState(() {
              widget.expenses.insert(index, removedExpense);
            });
          },
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.expenses.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text("No expenses found. Start adding some!")],
        ),
      );
    }
    return ListView.builder(
      // itemCount: _expenses.length,
      itemCount: widget.expenses.length,
      itemBuilder: (context, index) {
        final expense = widget.expenses[index];
        return Dismissible(
          key: ValueKey(expense.id),
          onDismissed: (direction) {
            removeExpense(index);
          },
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Icon(Icons.delete, color: Colors.white),
          ),
          child: ExpenseItem(expense: expense),
        );
      },
      // ExpenseItem(expense: widget.expenses[index]),
    );
  }
}

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({super.key, required this.expense});

  final Expense expense;

  IconData get expenseIcon {
    switch (expense.category) {
      case Category.food:
        return Icons.free_breakfast;
      case Category.travel:
        return Icons.travel_explore;
      case Category.leisure:
        return Icons.holiday_village;
      case Category.work:
        return Icons.work;
    }
  }

  String get expenseDate {
    return "${expense.date.day}/${expense.date.month}/${expense.date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("${expense.amount.toStringAsPrecision(2)} \$"),
                ],
              ),
              Spacer(),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Icon(expenseIcon),
                  ),
                  Text(expenseDate),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
