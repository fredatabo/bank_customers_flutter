import 'package:flutter/material.dart';
import 'package:bank_customers/models/customer.dart';

class CustomerItem extends StatelessWidget {
  const CustomerItem(this.customer, {super.key});

  final Customer customer;

  @override
  Widget build(BuildContext context) {
    String lname = customer.lname;
    String fname = customer.fname;

    String combo = '$lname  $fname';

    //String combo2 = lname + fname;
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 16,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            combo,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            customer.typeAccount,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('\$${customer.amount.toStringAsFixed(2)}'),
              const Spacer(),
              Row(
                children: [
                  Icon(accountTypeIcons[customer.accountType]),
                  const SizedBox(width: 8),
                  Text(customer.formattedDate)
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
