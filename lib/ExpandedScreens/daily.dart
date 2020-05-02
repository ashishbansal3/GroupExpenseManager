import 'package:flutter/material.dart';
import './listviewdaily.dart';
import 'package:provider/provider.dart';
import '../provider/transactions.dart';
import '../Widget/newtransaction.dart';
import './bottom_sheet.dart';
import '../Widget/dialy_transaction.dart';
import 'package:flutter/rendering.dart';
import '../provider/memberfunctions.dart';

class Daily extends StatefulWidget {
  @override
  _DailyState createState() => _DailyState();
}

class _DailyState extends State<Daily> {
  ScrollController _hideButtonController;
  var _isVisible;
  @override
  initState() {
    super.initState();
    _isVisible = true;
    _hideButtonController = new ScrollController();
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible == true) {
          /* only set when the previous state is false
             * Less widget rebuilds 
             */
          print("**** ${_isVisible} up"); //Move IO away from setState
          setState(() {
            _isVisible = false;
          });
        }
      } else {
        if (_hideButtonController.position.userScrollDirection ==
            ScrollDirection.forward) {
          if (_isVisible == false) {
            /* only set when the previous state is false
               * Less widget rebuilds 
               */
            print("**** ${_isVisible} down"); //Move IO away from setState
            setState(() {
              _isVisible = true;
            });
          }
        }
      }
    });
  }

  Widget build(BuildContext context) {
    var transaction = Provider.of<Transactions>(context, listen: true).item;
    var memebers = Provider.of<Members>(context).list;
    Map idToName = <String, String>{};
    for (var m in memebers) {
      idToName[m.userId] = m.name;
    }
    print('In daily view:');
    print(transaction.length);
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Expanded(
              child: ListView.builder(
                controller: _hideButtonController,
                shrinkWrap: true,
                itemCount: transaction.length,
                itemBuilder: (ctx, i) => DailyTransaction(
                    transaction[i], idToName[transaction[i].memberId]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          Visibility(visible: _isVisible, child: MyFloatingActionButton()),
    );
  }
}
