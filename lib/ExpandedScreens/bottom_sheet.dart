import 'dart:math';

import 'package:flutter/material.dart';
import '../provider/transactions.dart';
import '../Widget/newtransaction.dart';

class MyFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      mini: false,
      splashColor: Colors.limeAccent,
      elevation: 10,
      foregroundColor: Colors.black,
      backgroundColor: Colors.blue[300],
      child: Icon(Icons.add),
      onPressed: () => bottomsheet(context, null),
    );
  }
}

void bottomsheet(BuildContext ctx, String id) {
  showModalBottomSheet(
    elevation: 3.4,
    isDismissible: true,
    isScrollControlled: true,
    context: ctx,
    builder: (ctx) {
      return AnimatedPadding(
        padding: MediaQuery.of(ctx).viewInsets,
        duration: const Duration(milliseconds: 100),
        curve: Curves.decelerate,
        child: Container(height: 300, child: NewTransaction(id)),
      );
    },
  );
}
