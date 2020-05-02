import 'package:flutter/material.dart';
import '../provider/memberfunctions.dart';
import 'package:provider/provider.dart';
import '../models/member.dart';
class SelectMember extends StatefulWidget {
  @override
  static const routeName = 'select-member';
  _SelectMemberState createState() => _SelectMemberState();
}

class _SelectMemberState extends State<SelectMember> {
  @override

  Widget build(BuildContext context) {
    print('pehla');
    var members = Provider.of<Members>(context, listen: true).list;
    print(members);
    print('bachh');
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Members Included'),
      ),
      body: Center(
          child: Column(children: <Widget>[
        ListView.builder(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8.0),
          itemCount: members.length,
          itemBuilder: (BuildContext context, int index) {
            var item = members[index];
            return CheckboxListTile(
              title: Text(item.name),
              value: item.isActive,
              onChanged: (val) {
                setState(() {
                  item.isActive = val;
                });
              },
            );
          },
        ),
        RaisedButton(
          onPressed: () {Navigator.pop(context,[...members]);},
          child: Text("Save"),
        ),
      ])),
    );
  }
}
