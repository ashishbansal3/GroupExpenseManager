import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import '../provider/transactions.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '../provider/memberfunctions.dart';
import './selectmember.dart';
import '../models/transaction.dart';
import '../models/member.dart';
import '../provider/auth.dart';

class NewTransaction extends StatefulWidget {
  @override
  final id;
  NewTransaction(this.id);
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  @override
  bool _init = true;
  var textcontroller = TextEditingController(text: "");
  var amountcontroller = TextEditingController(text: '');
  List<dynamic> members = [];
  List<Member> selectedMembers = [];
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if (_init) {
      members = Provider.of<Members>(context, listen: true).list;
      if (widget.id != null) {
        final transaction =
            Provider.of<Transactions>(context).findById(widget.id);
        textcontroller = TextEditingController(text: transaction.title);
        amountcontroller =
            TextEditingController(text: transaction.price.toString());
      }
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    textcontroller.dispose();
    amountcontroller.dispose();
    super.dispose();
  }

  var _selectedDate = DateTime.now();
  var _isLoading = false;

  Future<void> _saveForm() async {
    _isLoading = true;
    print('object');
    Transaction _initialValue = Transaction(
      id: DateTime.now().toString(),
      title: textcontroller.text,
      date: _selectedDate.toString(),
      price: num.parse(amountcontroller.text),
      isSelected: false,
      memberId: Provider.of<Auth>(context, listen: false).uid,
      members: selectedMembers,
    );
    // if (widget.id == null) {
    //   print('add transaction');
    //   print(_initialValue);
    //   Provider.of<Transactions>(context, listen: false)
    //       .addTransaction(_initialValue);
    // } else {
    //   Provider.of<Transactions>(context, listen: false)
    //       .updateProduct(widget.id, _initialValue);
    // }
    if (widget.id == null) {
      try {
        await Provider.of<Transactions>(context, listen: false)
            .addTransaction(_initialValue);
      } catch (error) {
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('error occured!'),
            content: Text('Something went wrong!'),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Okay'),
              ),
            ],
          ),
        );
      }
      // finally {
      //   setState(() {
      //     _isLoading = false;
      //   });
      // }
    } else {
      Provider.of<Transactions>(context, listen: false)
          .updateProduct(widget.id, _initialValue);
    }
  }

  Future<Void> temporary(BuildContext context) async {
    try {
      //  members= await Navigator.of(context).pushNamed<dynamic>(SelectMember.routeName);
      members = await Navigator.of(context)
          .pushNamed<dynamic>(SelectMember.routeName);

      for (int i = 0; i < members.length; i++) {
        if (members[i].isActive == true) selectedMembers.add(members[i]);
        print(members[i].name);
        print("     ");
        print(members[i].isActive);
      }
    } catch (error) {
      print(error);
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
    print('...');
  }

  String ttl = "";
  double amount = 0.0;
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            // mainAxisAlignment: MainAxisAlignment.start ,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: "Title",
                ),
                controller: textcontroller,
              ),

              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: "Amount",
                ),
                controller: amountcontroller,
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(5),
                    color: Colors.grey,
                    textColor: Colors.black,
                    icon: Icon(Icons.date_range),
                    onPressed: _presentDatePicker,
                    label: Text(
                      DateFormat('dd-mm-yyyy').format(_selectedDate),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  FlatButton.icon(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: EdgeInsets.all(5),
                    color: Colors.grey,
                    textColor: Colors.black,
                    icon: Icon(Icons.people_outline),
                    onPressed: () {
                      temporary(context);
                    },
                    label: Text(
                      'Select Members',
                    ),
                  ),
                ],
              ),
              Spacer(),
              //add images
              Center(
                child: FloatingActionButton.extended(
                  onPressed: () {
                    Navigator.pop(context);
                    _saveForm();
                  },
                  backgroundColor: Colors.grey,
                  icon: Icon(
                    Icons.save,
                    color: Colors.black,
                  ),
                  label: Text(
                    "Save",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              SizedBox(
                height: 14,
              ),
            ],
          );
  }
}
