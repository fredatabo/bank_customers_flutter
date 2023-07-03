import 'package:flutter/material.dart';

import 'package:bank_customers/widgets/chart/chart_bar.dart';
import 'package:bank_customers/models/customer.dart';

class Chart extends StatelessWidget {
  const Chart({super.key, required this.customers});

  final List<Customer> customers;

  List<CustomerBucket> get buckets {
    return [
      CustomerBucket.forAccountType(customers, AccountType.savings),
      CustomerBucket.forAccountType(customers, AccountType.cooperate),
      CustomerBucket.forAccountType(customers, AccountType.current),
     
    ];
  }

  double get maxTotalAmount {
    double maxTotalAmount = 0;

    for (final bucket in buckets) {
      if (bucket.totalAmount > maxTotalAmount) {
        maxTotalAmount = bucket.totalAmount;
      }
    }

    return maxTotalAmount;
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode =
        MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.symmetric(
        vertical: 16,
        horizontal: 8,
      ),
      width: double.infinity,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.primary.withOpacity(0.3),
            Theme.of(context).colorScheme.primary.withOpacity(0.0)
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final bucket in buckets) // alternative to map()
                  ChartBar(
                    fill: bucket.totalAmount == 0
                        ? 0
                        : bucket.totalAmount / maxTotalAmount,
                  )
              ],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: buckets
                .map(
                  (bucket) => Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Icon(
                        accountTypeIcons[bucket.accountType],
                        color: isDarkMode
                            ? Theme.of(context).colorScheme.secondary
                            : Theme.of(context)
                                .colorScheme
                                .primary
                                .withOpacity(0.7),
                      ),
                    ),
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }
}