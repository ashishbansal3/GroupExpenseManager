// import 'package:flutter/material.dart';
// import '../provider/transaction.dart';
// import '../provider/transactions.dart';
// class ListViewDaily extends StatelessWidget {
//   @override
//   Transaction transaction;
//   int i;
//   ListViewDaily({this.transaction,this.i});


//   Widget extend() {
//     return (transaction.isSelected)
//         ? Container(
//             child: Column(
//               children: <Widget>[
//                 Divider(
//                   thickness: 2,
//                 ),
//                 Text('data'),
//               ],
//             ),
//           )
//         : Container();
//   }



//   Widget build(BuildContext context) {
//      return InkWell(
//       splashColor: Colors.black,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 250),
//         child: Card(
//           elevation: 2,
//           margin: EdgeInsets.all(1.5),
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('NAME'),
//                   ),
//                   Spacer(),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('PRICE'),
//                   ),
//                 ],
//               ),
//               extend(),
//             ],
//           ),
//         ),
//       ),
//       onTap: () {
//         setState(() {
//           transaction.isSelected = !transaction.isSelected;
//         });
//       },
//     );
//   }
// }
