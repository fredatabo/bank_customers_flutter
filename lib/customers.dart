import 'package:flutter/material.dart';
import 'package:bank_customers/models/customer.dart';
import 'package:bank_customers/widgets/customer_list.dart';
import 'package:bank_customers/new_customer.dart';
import 'package:bank_customers/widgets/chart/chart.dart';

class Customers extends StatefulWidget {
  const Customers({super.key});

  @override
  State<Customers> createState() => _CustomersState();
}

class _CustomersState extends State<Customers> {
  /*
   required this.fname,
  required this.lname,
  required this.accountType,
  required this.typeAccount,
  required this.amount,
  required this.date

  */
  final List<Customer> _registeredCustomers = [
    Customer(
        fname: 'John',
        lname: 'Tosin',
        accountType: AccountType.savings,
        typeAccount: 'savings',
        amount: 20.00,
        date: DateTime.now()),
    Customer(
        fname: 'Musa',
        lname: 'Freeman',
        accountType: AccountType.current,
        typeAccount: 'current',
        amount: 40.00,
        date: DateTime.now()),
  ];

  void _addCustomer(Customer customer) {
    setState(() {
      _registeredCustomers.add(customer);
    });
  }

  void _openAddCustomerOverlay() {
    showModalBottomSheet(
        isDismissible: true,
        context: context,
        builder: (ctx) => NewCustomer(onAddCustomer: _addCustomer));
  }

  void _removeCustomers(Customer customer) {
    final customerIndex = _registeredCustomers.indexOf(customer);
    setState(() {
      _registeredCustomers.remove(customer);
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          duration: const Duration(seconds: 3),
          content: const Text('customer deleted'),
          action: SnackBarAction(
              label: 'undo',
              onPressed: () {
                setState(() {
                  _registeredCustomers.insert(customerIndex, customer);
                });
              })),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget mainContent =
        const Center(child: Text('no customer found, start adding'));

    if (_registeredCustomers.isNotEmpty) {
      mainContent = CustomerList(
          customers: _registeredCustomers, onRemoveCustomer: _removeCustomers);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('bank customers'),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
              onPressed: _openAddCustomerOverlay, icon: const Icon(Icons.add)),
        ],
      ),
      body: Column(
        children: [
          const Text('The chart'),
          Chart(customers: _registeredCustomers),
          Expanded(child: mainContent)
        ],
      ),
    );
  }
}
