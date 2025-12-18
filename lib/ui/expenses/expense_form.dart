import 'package:flutter/material.dart';
import '../../models/expense.dart';

class ExpenseForm extends StatefulWidget {
  final void Function(Expense) onAddExpenes;
  const ExpenseForm({super.key, required this.onAddExpenes});

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  Category? selectedCategory;

  void onCreate() {
    // 1 - Create the new expense
    String title = _titleController.text.trim();
    // Category category = Category.food;

    if (title.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Input"),
          content: const Text("Title cannot be empty."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    double? amount = double.tryParse(_amountController.text);

    if (amount == null || amount <= 0) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Invalid Amount"),
          content: const Text("Please enter a valid positive number."),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Okay"),
            ),
          ],
        ),
      );
      return;
    }

    Expense newExpense = Expense(
      title: title,
      amount: amount,
      date: selectedDate,
      category: selectedCategory!,
    );
    // 2  - Forward the new expense to the parent
    widget.onAddExpenes(newExpense);

    // 3- Close the modal
    Navigator.pop(context);
  }

  void datePicker() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() => selectedDate = picked);
    }
  }

  void onCancel() {
    Navigator.pop(context);
  }

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(label: Text("Title")),
            maxLength: 50,
          ),
          TextField(
            controller: _amountController,
            decoration: InputDecoration(label: Text("Amount")),
            maxLength: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: datePicker,
                child: Icon(Icons.calendar_month),
              ),
              const SizedBox(width: 10),
              DropdownButton<Category>(
                hint: Text("Select Category"),
                value: selectedCategory,
                items: Category.values.map((category) {
                  return DropdownMenuItem(
                    value: category,
                    child: Text(category.toString().split('.').last),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCategory = newValue!;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
              const SizedBox(width: 10),
              ElevatedButton(onPressed: onCreate, child: Text("Create")),
            ],
          ),
          // ElevatedButton(onPressed: onCancel, child: Text("Cancel")),
          // ElevatedButton(onPressed: onCreate, child: Text("Create")),
        ],
      ),
    );
  }
}
