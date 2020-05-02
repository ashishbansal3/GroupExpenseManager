import 'package:flutter/material.dart';

class ParticularTransactions extends StatelessWidget {
  @override
  var listTransactions, ttl;
  ParticularTransactions({this.listTransactions, this.ttl});
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      margin: EdgeInsets.all(2),
      child: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
                itemCount: listTransactions.length,
                itemBuilder: (context, i) {
                  return Card(

                    color: Colors.cyan,
                    margin: EdgeInsets.all(3),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            listTransactions[i].title,
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child:
                              Text('₹ ${listTransactions[i].price.toString()}'),
                        ),
                      ],
                    ),
                  );
                }),
          ),
          Card(
            //chnage color of cardd;
            color: Colors.blueGrey,
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    'Total:',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text('\$${ttl}'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
