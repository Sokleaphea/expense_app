import 'package:expense_tracker/models/expense.dart';
import 'package:expense_tracker/ui/expenses/expenses.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/ui/expenses/expense_summary.dart';

import 'expenses/expense_form.dart';


class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Expense> _expenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
    ),
    Expense(
      title: 'Cinema',
      amount: 15.69,
      date: DateTime.now(),
      category: Category.leisure,
    ),
  ];
  void addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }
  void onAddClicked(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: false,
      context: context,
      builder: (c) => Center(child: ExpenseForm(onAddExpenes: addExpense)),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => onAddClicked(context),
            icon: Icon(Icons.add),
          ),
        ],
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
      ),
      // body: ExpensesView(expenses: _expenses),
      body: Column(
        children: [
          StatisticCard(expenses: _expenses),
          Expanded(child: ExpensesView(expenses: _expenses))
        ],
      ),
    );
  }
}

// class App extends StatelessWidget {
//   final expenseView = ExpensesView();
//   App({super.key});

//   void onAddClicked(BuildContext context) {
//     showModalBottomSheet(
//       isScrollControlled: false,
//       context: context,
//       builder: (c) => Center(child: ExpenseForm()),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[100],
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: () => {onAddClicked(context)},
//             icon: Icon(Icons.add),
//           ),
//         ],
//         backgroundColor: Colors.blue[700],
//         title: const Text('Ronan-The-Best Expenses App'),
//       ),
//       body: ExpensesView(),
//     );
//   }
// }
