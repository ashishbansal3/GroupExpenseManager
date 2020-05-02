import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widget/particular_transactions.dart';
import '../provider/transactions.dart';
import '../models/transaction.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';

class MyTransactions extends StatelessWidget {
  static const routeName = '/my-trans';
  @override
  Widget build(BuildContext context) {
    final List<Transaction> trans = Provider.of<Transactions>(context).item;
    final String idMember = Provider.of<Auth>(context).uid;
    List<Transaction> listTransactions = [];
    double ttl = 0.0;
    for (var t in trans) {
      if (t.memberId == idMember) {
        listTransactions.add(t);
        ttl += t.price;
      }
    }
    return ParticularTransactions(
      listTransactions: listTransactions,
      ttl: ttl,
    );
  }
}
