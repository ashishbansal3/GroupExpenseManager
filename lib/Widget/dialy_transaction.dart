import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/models/index.dart';
import '../ExpandedScreens/bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../provider/transactions.dart';
import '../models/transaction.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class DailyTransaction extends StatefulWidget {
  @override
  final Transaction transaction;
  final String name;
  DailyTransaction(this.transaction, this.name);
  _DailyTransactionState createState() => _DailyTransactionState();
}

class _DailyTransactionState extends State<DailyTransaction>
    with SingleTickerProviderStateMixin {
  @override
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 300,
      ),
    );
    _slideAnimation = Tween<Offset>(
      begin: Offset(0, -1.5),
      end: Offset(0, 0),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastOutSlowIn,
      ),
    );
    _opacityAnimation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
    // _heightAnimation.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  Widget slideRightBackground() {
    return Container(
      color: Colors.green,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: 20,
            ),
            Icon(
              Icons.edit,
              color: Colors.white,
            ),
            Text(
              " Edit",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.left,
            ),
          ],
        ),
        alignment: Alignment.centerLeft,
      ),
    );
  }

  Widget slideLeftBackground() {
    return Container(
      color: Colors.red,
      child: Align(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Icon(
              Icons.delete,
              color: Colors.white,
            ),
            Text(
              " Delete",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
              textAlign: TextAlign.right,
            ),
            SizedBox(
              width: 20,
            ),
          ],
        ),
        alignment: Alignment.centerRight,
      ),
    );
  }

  Widget memberName(String name) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Text(
        name,
        style: TextStyle(
          letterSpacing: 1.4,
          color: Colors.black,
          fontSize: 15,
        ),
      ),
    );
  }

  var _expanded = false;
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.transaction.id),
      background: slideRightBackground(),
      secondaryBackground: slideLeftBackground(),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.endToStart) {
          final bool res = await showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    title: Text('Do you really want to delete?'),
                    content: Text('Are you Sure!'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Provider.of<Transactions>(context, listen: false)
                              .deleteTransaction(widget.transaction.id);
                          Navigator.of(context).pop();
                        },
                        child: Text("Yes"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("No"),
                      ),
                    ],
                  ));
          return res;
        } else {
          // TODO: Navigate to edit page;
          showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                    elevation: 4,
                    title: Text('Edit this Transactions'),
                    actions: <Widget>[
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          bottomsheet(context, widget.transaction.id);
                        },
                        child: Text("Yes"),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("No"),
                      ),
                    ],
                  ));
        }
      },
      child: Card(
        elevation: 2,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 3),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.grey,
                child: Text(
                  widget.name[0].toUpperCase(),
                  style: TextStyle(color: Colors.black),
                ),
              ),
              title: Text(widget.transaction.title),
              subtitle: Text(widget.name),
              trailing: Container(
                padding: EdgeInsets.all(3),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('₹ ${widget.transaction.price.toString()}'),
                    Text(
                      DateFormat('dd/MM/yyyy')
                          .format(DateTime.parse(widget.transaction.date)),
                    ),
                  ],
                ),
              ),
              onTap: () {
                setState(() {
                  _expanded = !_expanded;
                });
              },
            ),
            SizedBox(
              height: 3,
            ),
            Divider(
              height: 2,
              color: Colors.white54,
            ),
            SizedBox(
              height: 6,
            ),
            if (_expanded)
              Container(
                color: Colors.grey,
                height: 125,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          border: BorderDirectional(
                              bottom: BorderSide(
                        width: 1,
                        color: Colors.white54,
                      ))),
                      child: Text(
                        'Members',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black87,
                          fontSize: 20,
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.transaction.members.length,
                          itemBuilder: (ctx, i) {
                            return memberName(
                                widget.transaction.members[i].name);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Card(
//           elevation: 2,
//           margin: EdgeInsets.all(1.5),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Text(
//                       widget.transaction.title,
//                       style: TextStyle(fontSize: 15),
//                     ),
//                   ),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(20),
//                     child: Text('\$${widget.transaction.price.toString()}'),
//                   ),
//                 ],
//               ),
//               extend(widget.transaction, context),
//             ],
//           ),
//         ),
