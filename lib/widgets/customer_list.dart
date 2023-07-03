import 'package:flutter/material.dart';
import 'package:bank_customers/models/customer.dart';
import 'package:bank_customers/widgets/customer_item.dart';

class CustomerList extends StatelessWidget {
  const CustomerList(
      {super.key, required this.customers, required this.onRemoveCustomer});

  final void Function(Customer customer) onRemoveCustomer;

  final List<Customer> customers;

  @override
  Widget build(BuildContext context) {
   

      


    return ListView.builder(
        itemCount: customers.length,
        itemBuilder: (ctx, index) => Dismissible(
              background: Container(
                color: Colors.red,
                margin: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
              ),
              key: ValueKey(customers[index]),
              onDismissed: (direction) {
                onRemoveCustomer(customers[index]);
              },
              child: CustomerItem(customers[index]),
            ));
  }
}
