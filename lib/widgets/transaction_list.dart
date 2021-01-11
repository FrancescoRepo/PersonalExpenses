import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses/transaction.dart';

class TransactionList extends StatelessWidget {
  TransactionList({Key key, this.transactions, this.removeTransaction})
      : super(key: key);

  final List<Transaction> transactions;
  final Function removeTransaction;

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text("No Transactions added yet"),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: constraints.maxHeight * 0.6,
                  child: Image.asset("assets/images/waiting.png",
                      fit: BoxFit.cover),
                )
              ],
            );
          })
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, i) {
              return Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: FittedBox(
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Text(
                          '\$${transactions[i].amount.toStringAsFixed(0)}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[i].title,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat().format(transactions[i].date),
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  trailing: MediaQuery.of(context).size.width > 360
                      ? FlatButton.icon(
                          textColor: Theme.of(context).errorColor,
                          icon: Icon(Icons.delete),
                          onPressed: () =>
                              removeTransaction(transactions[i].id),
                          label: Text("Delete"),
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.delete,
                            color: Theme.of(context).errorColor,
                          ),
                          onPressed: () {
                            removeTransaction(transactions[i].id);
                          },
                        ),
                ),
              );
            },
          );
  }
}
