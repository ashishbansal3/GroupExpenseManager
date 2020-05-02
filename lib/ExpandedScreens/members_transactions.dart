import 'package:flutter/material.dart';
import '../provider/transactions.dart';
import '../models/transaction.dart';
import 'package:provider/provider.dart';
import '../provider/auth.dart';
import '../provider/memberfunctions.dart';

class MemberTransactions extends StatelessWidget {
  static const routeName = '/member-trans';
  @override
  Widget build(BuildContext context) {
    final listTransactions =
        ModalRoute.of(context).settings.arguments as List<Transaction>;
    final members = Provider.of<Members>(context).list;
    Map<String, String> mp = {};
    for (var m in members) {
      mp[m.userId] = m.name;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('My Transactions'),
      ),
      body: Container(
        padding: EdgeInsets.all(2),
        margin: EdgeInsets.all(2),
        child: ListView.builder(
            itemCount: listTransactions.length,
            itemBuilder: (context, i) {
              return Card(
                elevation: 2,
                color: Colors.lightBlueAccent,
                margin: EdgeInsets.all(1.7),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.lightGreenAccent,
                        child: Text(
                          mp[listTransactions[i].memberId].substring(0, 1),
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      title: Text(listTransactions[i].title),
                      subtitle: Text(mp[listTransactions[i].memberId]),
                      trailing: Container(
                        padding: EdgeInsets.all(3),
                        child: Text(listTransactions[i].price.toString()),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
