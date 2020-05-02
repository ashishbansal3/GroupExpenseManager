import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/ExpandedScreens/particular_member_transactions.dart';
import 'package:provider/provider.dart';
import '../provider/memberfunctions.dart';
import '../models/member.dart';

class ShowMembers extends StatelessWidget {
  @override
  static const routeName = 'show-mem';
  Widget build(BuildContext context) {
    final List<Member> members = Provider.of<Members>(context).list;
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: Text('Members'),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(5),
        child: ListView.builder(
          itemCount: members.length,
          itemBuilder: (context, i) {
            return ListTile(
              leading: Text(
                '${(i + 1)}. ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text(members[i].name.toString()),
              onTap: () {
                return Navigator.of(context).pushNamed(
                    ParticularMemberTransactions.routeName,
                    arguments: members[i].userId);
              },
            );
          },
        ),
      ),
    );
  }
}
