import 'package:flutter/material.dart';
import 'package:bank_customers/models/customer.dart';

class NewCustomer extends StatefulWidget {
  const NewCustomer({super.key, required this.onAddCustomer});

  final void Function(Customer customer) onAddCustomer;

  @override
  State<NewCustomer> createState() => _NewCustomerState();
}

class _NewCustomerState extends State<NewCustomer> {
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;
  AccountType _selectedAccountType = AccountType.savings;

  // the method below removes the title controller from memory when the method is closed

  @override
  void dispose() {
    _lnameController.dispose();
    _lnameController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  void _presentDatePicker() async {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 2, now.month, now.day);

    final pickDate = await showDatePicker(
        context: context,
        initialDate: now,
        firstDate: firstDate,
        lastDate: now);
    setState(() {
      _selectedDate = pickDate;
    });
  }

  void _submitCustomerData() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_lnameController.text.trim().isEmpty ||
        _fnameController.text.trim().isEmpty ||
        amountIsInvalid ||
        _selectedDate == null) {
      showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
                title: const Text('please enter a valid amount, date, or name'),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                      },
                      child: const Text('ok'))
                ],
              ));
      return;
    }
    widget.onAddCustomer(Customer(
      lname: _lnameController.text,
      fname: _fnameController.text,
      accountType: _selectedAccountType,
      typeAccount: _selectedAccountType.toString(),
      amount: enteredAmount,
      date: _selectedDate!,
    ));

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 48, 16, 16),
      child: Column(
        children: [
          TextField(
            controller: _lnameController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('last name'),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          TextField(
            controller: _fnameController,
            maxLength: 50,
            decoration: const InputDecoration(
              label: Text('first name'),
            ),
          ),
          Expanded(
            child: TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                prefixText: '\$',
                label: Text('Amount'),
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Row(
            children: [
              Text(_selectedDate == null
                  ? 'no date selected'
                  : formater.format(_selectedDate!)),
              IconButton(
                  onPressed: _presentDatePicker,
                  icon: const Icon(Icons.calendar_month)),
            ],
          ),
          Expanded(
            child: Row(
              children: [
                DropdownButton(
                    value: _selectedAccountType,
                    items: AccountType.values
                        .map(
                          (account) => DropdownMenuItem(
                              value: account,
                              child: Text(account.name.toString())),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value == null) {
                        return;
                      }
                      setState(() {
                        _selectedAccountType = value;
                      });
                    }),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('cancel'),
                ),
                ElevatedButton(
                    onPressed: _submitCustomerData,
                    child: const Text('Submit Data'))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
