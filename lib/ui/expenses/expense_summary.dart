import 'package:flutter/material.dart';
import '../../models/expense.dart';

const categoryIcon = {
  Category.food: Icons.free_breakfast,
  Category.travel: Icons.travel_explore,
  Category.leisure: Icons.holiday_village,
  Category.work: Icons.work,
};

class CategoryStat extends StatelessWidget {
  final Category category;
  final double total;
  const CategoryStat({super.key, required this.category, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Icon(categoryIcon[category], size: 40),
              const SizedBox(height: 6),
            ],
          ),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class StatisticCard extends StatefulWidget {
  final List<Expense> expenses;
  const StatisticCard({super.key, required this.expenses});

  @override
  State<StatisticCard> createState() => _StatisticCardState();
}

class _StatisticCardState extends State<StatisticCard> {
  double totalForCategory(Category category) {
    return widget.expenses
        .where((e) => e.category == category)
        .fold(0, (sum, e) => sum + e.amount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: Category.values.map((category) {
            final total = totalForCategory(category);
            return CategoryStat(category: category, total: total);
          }).toList(),
        ),
      ),
    );
  }
}
