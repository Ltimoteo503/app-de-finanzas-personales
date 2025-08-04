import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Budget App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Color(0xFFF5F5F5),
      ),
      home: BudgetScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class BudgetScreen extends StatefulWidget {
  @override
  _BudgetScreenState createState() => _BudgetScreenState();
}

class _BudgetScreenState extends State<BudgetScreen> {
  int _selectedIndex = 2; // Budget tab is selected

  final List<ExpenseItem> expenses = [
    ExpenseItem(
      icon: Icons.shopping_cart_outlined,
      title: 'Groceries',
      amount: 250,
    ),
    ExpenseItem(
      icon: Icons.directions_car_outlined,
      title: 'Transportation',
      amount: 150,
    ),
    ExpenseItem(
      icon: Icons.movie_outlined,
      title: 'Entertainment',
      amount: 100,
    ),
    ExpenseItem(
      icon: Icons.restaurant_outlined,
      title: 'Dining Out',
      amount: 50,
    ),
    ExpenseItem(
      icon: Icons.shopping_bag_outlined,
      title: 'Shopping',
      amount: 50,
    ),
  ];

  double get totalExpenses {
    return expenses.fold(0, (sum, item) => sum + item.amount);
  }

  double get remainingBudget {
    return 600; // Total budget
  }

  double get budgetProgress {
    double spent = totalExpenses;
    double total = remainingBudget + spent;
    return spent / total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5F5),
        elevation: 0,
        title: Text(
          'Budgets',
          style: TextStyle(
            color: Colors.black,
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add, color: Colors.black, size: 28),
            onPressed: () {
              // Add new budget functionality
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Monthly Budget Section
            Text(
              'Monthly Budget',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Remaining Budget
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Remaining',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  '${remainingBudget.toInt()}',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            // Progress Bar
            Container(
              height: 8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: Colors.grey[300],
              ),
              child: FractionallySizedBox(
                alignment: Alignment.centerLeft,
                widthFactor: budgetProgress,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.blue,
                  ),
                ),
              ),
            ),

            SizedBox(height: 40),

            // Expense Breakdown Section
            Text(
              'Expense Breakdown',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),

            // Expense List
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final expense = expenses[index];
                  return Container(
                    margin: EdgeInsets.only(bottom: 20),
                    child: Row(
                      children: [
                        // Icon Container
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            expense.icon,
                            color: Colors.black54,
                            size: 20,
                          ),
                        ),
                        SizedBox(width: 15),

                        // Title and Amount
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                expense.title,
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                              SizedBox(height: 2),
                              Text(
                                '\$${expense.amount.toInt()}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 8,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.attach_money_outlined),
            activeIcon: Icon(Icons.attach_money),
            label: 'Expenses',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart_outlined),
            activeIcon: Icon(Icons.bar_chart),
            label: 'Budget',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class ExpenseItem {
  final IconData icon;
  final String title;
  final double amount;

  ExpenseItem({
    required this.icon,
    required this.title,
    required this.amount,
  });
}
