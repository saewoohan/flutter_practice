import 'package:flutter/material.dart';
import 'package:third_app/new_expense.dart';
import 'package:third_app/widgets/expenses-list/expenses_list.dart';
import 'package:third_app/models/expense.dart';
import 'package:third_app/widgets/chart/chart.dart';

class Expenses extends StatefulWidget{
  const Expenses({super.key});

  @override
  State<Expenses> createState() {
    return _ExpensesState();
  }

}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeresExpenses = [
    Expense(
      title: 'Flutter ourse',
      amount: 19.99,
      date: DateTime.now(),
      category: Category.work,
      ),
    Expense(
      title: ' ourse',
      amount: 20.99,
      date: DateTime.now(),
      category: Category.leisure,
      ),
  ];

  void _openAddExpenseOverlay(){
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context, builder: (ctx) => NewExpense(onAddExpense: _addExpense));
  }

  void _addExpense(Expense expense){
    setState((){
      _registeresExpenses.add(expense);
    });
  }

  void _removeExpense(Expense expense){
    final expenseIndex = _registeresExpenses.indexOf(expense);
    setState((){
      _registeresExpenses.remove(expense);
    });
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: const Text('Expense deleted.'),
        action: SnackBarAction(
          label: 'Undo', 
          onPressed: () {
            setState((){
              _registeresExpenses.insert(expenseIndex, expense);
            });
          }),
        )
      );
  }
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    Widget mainContent = const Center(child: Text('No expense found. Start adding some!'));

    if(_registeresExpenses.isNotEmpty){
      mainContent = ExpensesList(expenses: _registeresExpenses, onRemoveExpense: _removeExpense,);
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter ExpenseTracker'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed:_openAddExpenseOverlay,
            ), 
          
        ],
      ),
      body: width < 600 ? Column(
      children: [
        Chart(expenses: _registeresExpenses),
        Expanded(child: mainContent),
      ],
    ) : Row(children: [
        Expanded(child: Chart(expenses: _registeresExpenses)),
        Expanded(child: mainContent),
    ]),
    );
  }

}