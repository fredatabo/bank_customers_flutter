import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

final formater = DateFormat.yMd();

// generate automatic id
const uuid = Uuid();

enum AccountType { savings, current, cooperate }

const accountTypeIcons = {
  AccountType.savings: Icons.money,
  AccountType.current: Icons.credit_card,
  AccountType.cooperate: Icons.monetization_on_sharp
};

class Customer {
  Customer(
      {required this.fname,
      required this.lname,
      required this.accountType,
      required this.typeAccount,
      required this.amount,
      required this.date})
      : id = uuid.v4();

  final String id;
  final String fname;
  final String lname;
  final AccountType accountType;
  final String typeAccount;
  final double amount;
  final DateTime date;

  String get formattedDate {
    return formater.format(date);
  }
}

class CustomerBucket {
  const CustomerBucket({required this.accountType, required this.customers});

 

  CustomerBucket.forAccountType(List<Customer> allCustomers, this.accountType)
      : customers = allCustomers
            .where((customer) => customer.accountType == accountType)
            .toList();

             final AccountType accountType;
  final List<Customer> customers;

  double get totalAmount {
    double sum = 0;
    for(final customer in customers){
      sum += customer.amount;
    }
    return sum;
  }
}
