import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;
  TransactionList(
    this.transactions,
    this.deleteTx,
  );

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('₹${transactions[index].amount}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[index].title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat.yMMMd().format(transactions[index].date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 460
                      ? TextButton.icon(
                          onPressed: () {
                            deleteTx(transactions[index].id);
                          },
                          icon: const Icon(Icons.delete),
                          style: TextButton.styleFrom(
                              primary: Theme.of(context).errorColor),
                          label: const Text('Delete'),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deleteTx(transactions[index].id);
                          },
                        ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
