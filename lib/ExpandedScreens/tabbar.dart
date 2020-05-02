import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/ExpandedScreens/my_transaction.dart';
import '../ExpandedScreens/particular_member_transactions.dart';

import '../ExpandedScreens/accordingmembers.dart';

import './overallhisab.dart';
import './daily.dart';
import 'package:provider/provider.dart';
import '../provider/transactions.dart';
import '../provider/memberfunctions.dart';
import '../provider/auth.dart';
import 'dart:convert';
import '../ExpandedScreens/show_members.dart';
import '../Widget/newtransaction.dart';
import './bottom_sheet.dart';
import './home.dart';

class TabBarr extends StatefulWidget {
  @override
  static const routeName = '/expense';

  _TabBarState createState() => _TabBarState();
}

class _TabBarState extends State<TabBarr> {
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // WON'T WORK!
    // Future.delayed(Duration.zero).then((_) {
    //   Provider.of<Products>(context).fetchAndSetProducts();
    // });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    print('object');
    final String authToken = Provider.of<Auth>(context).token;
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Transactions>(context).fetchAndSetProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
      print('ftch member from tabbar');
      Provider.of<Members>(context).fetchAndSetProducts(authToken);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Widget build(BuildContext context) {
    final _userId = Provider.of<Auth>(context).uid;
    final _members = Provider.of<Members>(context).list;
    String name = "temp";
    print('Starting');
    print(_members);
    if (_members != null)
      for (var m in _members) {
        if (m.userId == _userId) {
          name = m.name;
          break;
        }
      }
    return DefaultTabController(
      length: 4,
      child: name == "temp"
          ? CircularProgressIndicator()
          : Scaffold(
              resizeToAvoidBottomInset: true,
              resizeToAvoidBottomPadding: false,
              // drawer: AppDrawer(),
              appBar: AppBar(
                elevation: 3,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(5),
                        topRight: Radius.elliptical(4, 4))),
                leading: CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent,
                  maxRadius: 1,
                  child: InkWell(
                    //onHover:,
                    onTap: () {
                      // my profile;
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 0.5,
                      child: Text(
                        name[0].toUpperCase(),
                        style: TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                
                backgroundColor: Colors.white,
                titleSpacing: 0.0,
                title: Text(
                  name,
                  style: TextStyle(color: Colors.grey),
                ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.people,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ShowMembers.routeName);
                    },
                    focusColor: Colors.lightBlueAccent,
                    tooltip: 'Members',
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.directions_run,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pushReplacementNamed('/');
                      Provider.of<Auth>(context, listen: false).logout();
                    },
                    focusColor: Colors.lightBlueAccent,
                    tooltip: 'Logout',
                  ),
                ],
                bottom: TabBar(
                  tabs: <Widget>[
                    Text(
                      'Daily',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'My Transactions',
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'According Members',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                    Text(
                      'Overall Hisab',
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              body: TabBarView(
                children: <Widget>[
                  Daily(),
                  MyTransactions(),
                  AccordingMember(),
                  OverallHisab(),
                ],
              ),
            ),
    );
  }
}
