import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/Widget/particular_transactions.dart';
import '../provider/transactions.dart';
import '../models/transaction.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../provider/memberfunctions.dart';

class ParticularMemberTransactions extends StatelessWidget {
  static const routeName = '/my-trans';
  @override
  // String idMember;
  // ParticularMemberTransactions(this.idMember);
  Widget build(BuildContext context) {
    final idMember = ModalRoute.of(context).settings.arguments as String;
    final List<Transaction> trans = Provider.of<Transactions>(context).item;
    String name;
    final members = Provider.of<Members>(context).list;
    List<Transaction> listTransactions = [];
    double ttl = 0.0;
    for (var m in members) {
      if (idMember == m.userId) {
        name = m.name;
        break;
      }
    }
    for (var t in trans) {
      if (t.memberId == idMember) {
        listTransactions.add(t);
        ttl += t.price;
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Transactions of ${name}'),
      ),
      body: ParticularTransactions(
        listTransactions: listTransactions,
        ttl: ttl,
      ),
    );
  }
}
