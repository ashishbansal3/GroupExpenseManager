import 'package:flutter/material.dart';
import '../provider/transactions.dart';
import '../provider/memberfunctions.dart';
import 'package:provider/provider.dart';
import '../models/transaction.dart';

class KeyValue {
  String name;
  double amount = 0.0;
  KeyValue({this.name, this.amount});
}

class OverallHisab extends StatelessWidget {
  var finalHisab = <String, List<KeyValue>>{};
  var debit = <String, List<KeyValue>>{};
  Map nameToId = Map<String, String>();
  Map idToName = Map<String, String>();
  Widget rowshow(var a) {
    return Container(
        padding: EdgeInsets.all(3),
        child: Text(
          a.toString(),
          softWrap: false,
          style: TextStyle(
            //  color: a < 0 ? Colors.red : Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ));
  }

  Widget rowshow2(var a) {
    return Container(
        padding: EdgeInsets.all(1.5),
        child: Text(
          a.toString(),
          softWrap: true,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.4,
          ),
        ));
  }

  Widget tempWidget(String name, double amount) {
    print('in temp');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        rowshow(name),
        rowshow('₹ ${amount.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget ttlAmount(String name, double amount) {
    print('in temp');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        rowshow2(name),
        rowshow2('₹ ${amount.toStringAsFixed(2)}'),
      ],
    );
  }

  Widget printlist(var list) {
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 4,
      ),
      width: 155,
      height: 110,
      child: list != null
          ? ListView.builder(
              itemCount: list.length,
              itemBuilder: (ctx, i) {
                return tempWidget(list[i].name, list[i].amount);
              },
            )
          : Icon(Icons.insert_emoticon, size: 35),
    );
  }

  // Widget columnlist(String type, var list) {
  //   // return Column(
  //   //   children: <Widget>[
  //   return   Text(
  //         type,
  //         style: TextStyle(
  //           letterSpacing: 1.5,
  //           height: 17,
  //           fontWeight: FontWeight.w400,
  //         ),
  //       ),
  //       // printlist(debit),
  //   //   ],
  //   // );
  // }

  Widget cardd(List<KeyValue> credit, List<KeyValue> debit, String name) {
    print('in card');
    double ttlDebit = 0.0, ttlCredit = 0.0;
    if (credit != null)
      for (var c in credit) {
        ttlCredit += c.amount;
      }

    if (debit != null)
      for (var d in debit) {
        ttlDebit += d.amount;
      }
    return Card(
      color: Colors.lightBlueAccent,
      elevation: 2.5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      child: Container(
        height: 250,
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.symmetric(vertical: 5, horizontal: 2),
        child: Column(
          children: <Widget>[
            Text(
              name,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white54,
                fontWeight: FontWeight.bold,
                fontSize: 24,
                letterSpacing: 1.3,
              ),
            ),
            Divider(
              height: 2,
              color: Colors.white54,
            ),
            SizedBox(
              height: 17,
            ),
// tempWidget(
//                                   credit[i].name, credit[i].amount);
            Container(
                height: 190,
                width: 500,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Text(
                          'CREDIT',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4,
                          ),
                        ),
                        printlist(credit),
                        SizedBox(
                          height: 10,
                        ),
                        ttlAmount('TOTAL:', ttlCredit),
                      ],
                    ),
                    VerticalDivider(
                      thickness: 2,
                      color: Colors.white54,
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          'DEBIT',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.4,
                          ),
                        ),
                        printlist(debit),
                        SizedBox(
                          height: 10,
                        ),
                        ttlAmount('TOTAL:', ttlDebit),
                      ],
                    ),
                  ],
                )),
            //   printlist(credit),
            // SingleChildScrollView(
            //               child: Container(
            //     height: 100,
            //     decoration: BoxDecoration(border: Border.all()),
            //     padding: EdgeInsets.all(3),
            //     child: Row(
            //       crossAxisAlignment: CrossAxisAlignment.start,
            //       children: <Widget>[
            //         Container(
            //           width: 120,
            //           child: columnlist("CREDIT", credit),
            //         ),
            //         Container(
            //           width: 120,
            //           child: columnlist("DEBIT", debit),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    finalHisab.clear();
    nameToId.clear();
    debit.clear();
    idToName.clear();
    var transactions = Provider.of<Transactions>(context).item;
    var members = Provider.of<Members>(context).list;

    for (int i = 0; i < members.length; i++) {
      nameToId[members[i].name] = members[i].userId;
      idToName[members[i].userId] = members[i].name;
    }
    print('1');
    for (var t in transactions) {
      double ttlAmount = t.price.toDouble();
      double perPerson = ttlAmount / (t.members.length);
      String name = idToName[t.memberId];
      //   print(name);
      for (var m in t.members) {
        if (m.name != name) {
          if (finalHisab.containsKey(name)) {
            int flag = 0;

            for (int i = 0; i < finalHisab[name].length; i++) {
              if (finalHisab[name][i].name == m.name) {
                flag = 1;
                finalHisab[name][i].amount += perPerson;
              }
            }

            if (flag == 0) {
              finalHisab[name].add(KeyValue(name: m.name, amount: perPerson));
            }

            // var map1 = Map.fromIterable(finalHisab[name],
            //     key: (e) => e.name, value: (e) => e.amount);
            // if (map1.containsKey(m.name)) {
            //   map1[m.name] = map1[m.name] + perPerson;
            // } else {
            //   map1[m.name] = perPerson;
            // }
            // map1.forEach(
            //     (k, v) => finalHisab[name].add(KeyValue(name: k, amount: v)));
          } else {
            finalHisab[name] = <KeyValue>[];
            finalHisab[name].add(KeyValue(name: m.name, amount: perPerson));
          }
        }
      }
      //   print(finalHisab);

    }
    print('2');
    for (int i = 0; i < members.length; i++) {
      String name1 = members[i].name;
      if (finalHisab[members[i].name] == null) continue;

      for (int j = 0; j < finalHisab[name1].length; j++) {
        String name2 = finalHisab[name1][j].name;
        double amount1 = finalHisab[name1][j].amount;
        if (finalHisab[name2] == null) continue;
        for (int k = 0; k < finalHisab[name2].length; k++) {
          if (finalHisab[name2][k].name == name1) {
            double amount2 = finalHisab[name2][k].amount;
            if (amount1 >= amount2) {
              finalHisab[name1][j].amount -= amount2;
              finalHisab[name2][k].amount = 0;
              if (finalHisab[name2].length == 1)
                finalHisab[name2] = null;
              else
                finalHisab[name2].removeAt(k);
            } else {
              finalHisab[name1][j].amount = 0;
              finalHisab[name2][k].amount -= amount1;
              if (finalHisab[name1].length == 1)
                finalHisab[name1] = null;
              else {
                finalHisab[name1].removeAt(j);
                j--;
              }
            }
            break;
          }
        }
      }
    }
    print('bale bale bale');
    for (int i = 0; i < members.length; i++) {
      String name1 = members[i].name;
      print(name1);
      print(':=>');
      if (finalHisab[members[i].name] == null) continue;
      for (int j = 0; j < finalHisab[members[i].name].length; j++) {
        String name2 = finalHisab[members[i].name][j].name;

        print(finalHisab[name1][j].name);
        print(finalHisab[name1][j].amount);
      }
    }

    print('3');
    for (int i = 0; i < members.length; i++) {
      String name1 = members[i].name;

      if (finalHisab[members[i].name] == null) continue;
      for (int j = 0; j < finalHisab[name1].length; j++) {
        String name2 = finalHisab[name1][j].name;
        print('${name1}   ${name2}');
        if (debit.containsKey(name2)) {
          print('in if');
          debit[name2].add(KeyValue(
            name: name1,
            amount: finalHisab[name1][j].amount,
          ));
        } else {
          print('in else');
          debit[name2] = <KeyValue>[];
          debit[name2]
              .add(KeyValue(name: name1, amount: finalHisab[name1][j].amount));
        }
      }
    }

    print('debittttttttttttttt');

    for (int i = 0; i < members.length; i++) {
      String name1 = members[i].name;
      print(name1);
      print(':=>');
      if (debit[members[i].name] == null) continue;
      for (int j = 0; j < debit[members[i].name].length; j++) {
        String name2 = debit[members[i].name][j].name;

        print(debit[name1][j].name);
        print(debit[name1][j].amount);
      }
    }

    return Container(
      height: double.infinity,
      width: double.infinity,
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(2.5),
      child: ListView.builder(
        itemCount: members.length,
        itemBuilder: (ctx, i) {
          return finalHisab[members[i].name] == null &&
                  debit[members[i].name] == null
              ? Container(
                  height: 0,
                )
              : cardd(finalHisab[members[i].name], debit[members[i].name],
                  members[i].name);
        },
      ),
    );
  }
}
