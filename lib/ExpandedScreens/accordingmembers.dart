import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/ExpandedScreens/members_transactions.dart';
import 'package:provider/provider.dart';
import '../provider/transactions.dart';
import '../models/transaction.dart';
import '../models/member.dart';
import '../provider/memberfunctions.dart';
import '../models/member.dart';

// class KeyValue {
//   String name;
//   int amount;
//   KeyValue({this.name, this.amount});
// }

class AccordingMember extends StatelessWidget {
  @override
  //var finalHisab = <String, List<KeyValue>>{};
  // Map idToName = Map<String, String>();
  Map nameToId = Map<String, String>();

  Widget rowshow(var a) {
    return Container(
        padding: EdgeInsets.all(1),
        child: Text(
          a.toString(),
          softWrap: false,
          style: TextStyle(
            color: Colors.white54,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1.3,
          ),
        ));
  }

  Widget rowshow2(var a, int b) {
    return Container(
        padding: EdgeInsets.all(1),
        child: Text( b==0?
          a.toString():'₹ ${a}',
          softWrap: false,
          style: TextStyle(
            color: b == 1 && a < 0 ? Colors.red : Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ));
  }

  Widget showparallel(String name, int amount, int perPerson) {
    int remaining = amount == null ? -perPerson : amount - perPerson;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        rowshow2(name, 0),
        rowshow2(amount == null ? "0" : amount, 0),
        rowshow2(remaining, 1),
      ],
    );
  }

  Widget cardd(BuildContext context, var transactions) {
    print('reached cardd');
    var amountOfparticular = <String, int>{};
    int ttlAmount = 0, perPerson;
    for (Transaction trans in transactions) {
      if (amountOfparticular.containsKey(trans.memberId)) {
        amountOfparticular[trans.memberId] += trans.price;
      } else {
        amountOfparticular[trans.memberId] = trans.price;
      }
      ttlAmount = ttlAmount + trans.price;
    }

    perPerson = (ttlAmount / (transactions[0].members.length)).toInt();

    // print(perPerson);
    // print(transactions[0].members[0].name);
    // print(mapMember[transactions[0].members[0].name]);
    // print(amountOfparticular[mapMember[transactions[0].members[0].name]]);
    return Card(
      elevation: 3.5,
      color: Colors.lightBlue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(3),
      ),
      child: Container(
        padding: EdgeInsets.all(5),
        height: 250,
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                rowshow('Member'),
                rowshow('Amount'),
                rowshow('Final'),
              ],
            ),
            Divider(
              height: 2,
            ),
            Expanded(
              flex: 1,
              child: ListView.builder(
                  itemCount: transactions[0].members.length,
                  itemBuilder: (context, i) {
                    return showparallel(
                      transactions[0].members[i].name,
                      amountOfparticular[
                          nameToId[transactions[0].members[i].name]],
                      perPerson,
                    );
                  }),
            ),
            Divider(
              height: 2,
              color: Colors.white60,
            ),
            Row(
              children: <Widget>[
                rowshow("Total Amount:"),
                SizedBox(
                  width: 20,
                ),
                rowshow(ttlAmount),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: <Widget>[
                rowshow("Per Person:"),
                SizedBox(
                  width: 20,
                ),
                rowshow(perPerson),
              ],
            ),
            Divider(
              height: 2,
              color: Colors.white60,
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pushNamed(MemberTransactions.routeName,
                    arguments: transactions);
              },
              child: Text('Show All Transactions'),
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    //maps
    var mp = <String, List<Transaction>>{};
    List<String> mapString = <String>[];

    //providers
    var transactions = Provider.of<Transactions>(context).item;
    var members = Provider.of<Members>(context).list;
    // print('in for loop members');
    for (int i = 0; i < members.length; i++) {
      nameToId[members[i].name] = members[i].userId;
      //  idToName[members[i].userId] = members[i].name;
    }

    for (int i = 0; i < transactions.length; i++) {
      String temp = "";

      for (int j = 0; j < transactions[i].members.length; j++) {
        temp += transactions[i].members[j].name;
      }
      if (mp.containsKey(temp)) {
        mp[temp].add(transactions[i]);
      } else {
        print(transactions[i]);
        mp[temp] = <Transaction>[];
        mp[temp].add(transactions[i]);
        mapString.add(temp);
      }
      // print(mapMember);
      // print(mp.length);
      // print(mp[mapString[0]]);
    }
    //print('4');
    return ListView.builder(
        itemCount: mp.length,
        itemBuilder: (context, i) {
          return cardd(
            context,
            mp[mapString[i]],
          );
        });
  }
}
