import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/providers/theme_provider.dart';
import 'package:expense_tracker/providers/currency_provider.dart';
import 'package:expense_tracker/providers/budget_provider.dart';
import 'package:expense_tracker/widgets/animated_theme_switcher.dart';
import '../widgets/expense_card.dart';
import '../widgets/summary_card.dart';
import 'add_edit_expense_screen.dart';
import 'stats_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _showBudgetDialog(BuildContext context) {
    final provider = context.read<BudgetProvider>();
    final controller = TextEditingController(text: provider.budget.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Set Monthly Budget'),
        content: TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(
            labelText: 'Amount',
            prefixIcon: Icon(Icons.payments_rounded),
          ),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final val = double.tryParse(controller.text) ?? 0.0;
              provider.setBudget(val);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDark;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInOut,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Expenses'),
          actions: [
            IconButton(
              icon: const Icon(Icons.account_balance_rounded),
              tooltip: 'Set Monthly Budget',
              onPressed: () => _showBudgetDialog(context),
            ),
            PopupMenuButton<Currency>(
              icon: const Icon(Icons.payments_outlined),
              tooltip: 'Change Currency',
              onSelected: (currency) =>
                  context.read<CurrencyProvider>().setCurrency(currency),
              itemBuilder: (context) => Currency.values
                  .map((c) => PopupMenuItem(
                        value: c,
                        child: Text('${c.code} (${c.symbol.trim()})'),
                      ))
                  .toList(),
            ),
            IconButton(
              icon: const Icon(Icons.bar_chart_rounded),
              onPressed: () => Navigator.push(
                context,
                PageRouteBuilder(
                  transitionDuration: const Duration(milliseconds: 400),
                  pageBuilder: (_, a, __) => FadeTransition(
                    opacity: a,
                    child: const StatsScreen(),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(right: 16),
              child: Center(child: AnimatedThemeSwitcher()),
            ),
          ],
        ),
        body: Consumer<ExpenseProvider>(
          builder: (context, provider, _) {
            if (provider.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: CustomScrollView(
                key: ValueKey(isDark),
                slivers: [
                  SliverToBoxAdapter(
                    child: SummaryCard(
                      total: provider.totalSpent,
                      monthly: provider.monthlySpent,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 24)),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Transactions',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${provider.expenses.length} items',
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 12)),
                  if (provider.expenses.isEmpty)
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.receipt_long_rounded,
                              size: 80,
                              color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.3),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              'No expenses yet.\nAdd your first one!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Theme.of(context).textTheme.bodySmall?.color?.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  else
                    SliverList.builder(
                      itemCount: provider.expenses.length,
                      itemBuilder: (context, i) {
                        final expense = provider.expenses[i];
                        return TweenAnimationBuilder<double>(
                          duration: Duration(milliseconds: 300 + (i * 60)),
                          curve: Curves.easeOutCubic,
                          tween: Tween(begin: 0, end: 1),
                          builder: (_, value, child) => Transform.translate(
                            offset: Offset(0, 30 * (1 - value)),
                            child: Opacity(opacity: value, child: child),
                          ),
                          child: ExpenseCard(
                            expense: expense,
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AddEditExpenseScreen(expense: expense),
                              ),
                            ),
                            onDelete: () => provider.deleteExpense(expense.id!),
                          ),
                        );
                      },
                    ),
                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
          icon: const Icon(Icons.add_rounded),
          label: const Text('Add Expense', style: TextStyle(fontWeight: FontWeight.w600)),
          onPressed: () => Navigator.push(
            context,
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (_, a, __) => SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
                    .chain(CurveTween(curve: Curves.easeOutCubic))
                    .animate(a),
                child: const AddEditExpenseScreen(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}